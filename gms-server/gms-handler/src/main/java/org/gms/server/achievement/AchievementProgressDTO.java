package org.gms.server.achievement;

import java.math.BigDecimal;
import java.math.RoundingMode;

/**
 * 传输进度
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 19:53
 */

public class AchievementProgressDTO {
    private String category;
    private String categoryName;
    private int currentProgress;
    private int maxProgress;
    private double weightPercent;
    private double currentDiscountPercent; // 当前该项实际贡献的折扣百分比

    public AchievementProgressDTO(String category, String categoryName, int currentProgress, int maxProgress, double weightPercent) {
        this.category = category;
        this.categoryName = categoryName;
        this.currentProgress = currentProgress;
        this.maxProgress = maxProgress;
        this.weightPercent = weightPercent;

        // 计算当前该项实际折算的血量比重
        if (maxProgress > 0) {
            double ratio = Math.min(1.0, (double) currentProgress / maxProgress);
            double rawDiscount = ratio * weightPercent;

            // 保留两位小数 (HALF_UP 四舍五入)
            this.currentDiscountPercent = BigDecimal.valueOf(rawDiscount)
                    .setScale(2, RoundingMode.HALF_UP)
                    .doubleValue();
        } else {
            this.currentDiscountPercent = 0.0;
        }
    }

    // Getters
    public String getCategory() { return category; }
    public String getCategoryName() { return categoryName; }
    public int getCurrentProgress() { return currentProgress; }
    public int getMaxProgress() { return maxProgress; }
    public double getWeightPercent() { return weightPercent; }
    public double getCurrentDiscountPercent() { return currentDiscountPercent; }
    public boolean isMax() { return currentProgress >= maxProgress; }
}
