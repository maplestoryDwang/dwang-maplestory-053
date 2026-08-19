package org.gms.property;

import lombok.Data;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "gms.service")
@Component
@Data
public class ServiceProperty {
    private String language;
    private RateLimitProperty rateLimit;
    private String wanHost;
    private String lanHost;
    private String localhost;

    /**
     * 客户端启动登录端口
     */
    private int loginPort;
    /**
     *
     */
    @Value("17575")
    private int channelPort;

    @Data
    public static class RateLimitProperty {
        private boolean enabled;
        private int limit;
        private long duration;
        private boolean autoBan;
    }
}
