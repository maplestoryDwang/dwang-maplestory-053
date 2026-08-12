package org.gms.dto;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 15:37
 */

import java.io.Serializable;

public class NpcMenuDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private int categoryId;
    private int menuIndex;
    private String categoryName;

    public NpcMenuDTO() {}

    public NpcMenuDTO(int categoryId, int menuIndex, String categoryName) {
        this.categoryId = categoryId;
        this.menuIndex = menuIndex;
        this.categoryName = categoryName;
    }

    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    public int getMenuIndex() { return menuIndex; }
    public void setMenuIndex(int menuIndex) { this.menuIndex = menuIndex; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}