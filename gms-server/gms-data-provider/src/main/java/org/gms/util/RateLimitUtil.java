package org.gms.util;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;
import org.gms.model.pojo.RateLimitContext;
import org.gms.property.ServiceProperty;
import org.gms.service.AccountService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 客户端限流
 */
@Slf4j
@Component
public class RateLimitUtil {

    // 1. 静态单例指针（供外部 getInstance() 调用）
    private static RateLimitUtil instance;

    // 2. 由 Spring 注入依赖的字段
    private final ServiceProperty serviceProperty;
    private final AccountService accountService;

    // 3. 并发安全 Map
    private final Map<String, RateLimitContext> contextMap = new ConcurrentHashMap<>();

    // 4. 构造器注入 Spring 依赖
    public RateLimitUtil(ServiceProperty serviceProperty, AccountService accountService) {
        this.serviceProperty = serviceProperty;
        this.accountService = accountService;
    }

    // 5. 借助 @PostConstruct 在 Bean 初始化完成后为静态字段赋值
    @PostConstruct
    public void init() {
        instance = this;
    }

    // 6. 保留原本的 getInstance()，外部调用方式完全不变
    public static RateLimitUtil getInstance() {
        return instance;
    }

    public boolean check(String ip) {
        ServiceProperty.RateLimitProperty rateLimitProperty = serviceProperty.getRateLimit();
        if (!rateLimitProperty.isEnabled()) {
            return true;
        }
        try {
            long now = System.currentTimeMillis();

            // 使用 compute 保证多线程并发下更新同一个 IP 状态的原子性
            RateLimitContext context = contextMap.compute(ip, (k, existingContext) -> {
                if (existingContext == null || existingContext.getExpire() < now) {
                    RateLimitContext newContext = new RateLimitContext();
                    newContext.setCurr(new AtomicInteger(1));
                    newContext.setExpire(now + rateLimitProperty.getDuration());
                    return newContext;
                }
                existingContext.getCurr().incrementAndGet();
                return existingContext;
            });

            if (context.getCurr().get() > rateLimitProperty.getLimit()) {
                if (rateLimitProperty.isAutoBan()) {
                    accountService.ban(ip, "Auto banned by rate limit", true);
                }
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error("Rate limit check error for IP: {}", ip, e);
        }
        return false;
    }

    // 定时清理过期 IP，防止 HashMap 内存泄漏
    @Scheduled(fixedRate = 60000)
    public void cleanExpiredContexts() {
        long now = System.currentTimeMillis();
        contextMap.entrySet().removeIf(entry -> entry.getValue().getExpire() < now);
    }
}