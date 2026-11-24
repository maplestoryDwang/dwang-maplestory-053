package org.gms.ai;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "gms.ai")
public class BotProperties {
    private boolean enabled;
    private int characterId;
    private Integer walkTargetX;
    private Integer walkTargetY;

    public Integer getWalkTargetX() {
        return walkTargetX;
    }

    public void setWalkTargetX(Integer walkTargetX) {
        this.walkTargetX = walkTargetX;
    }

    public Integer getWalkTargetY() {
        return walkTargetY;
    }

    public void setWalkTargetY(Integer walkTargetY) {
        this.walkTargetY = walkTargetY;
    }

    public boolean isEnabled() {
        return enabled;
    }

    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
    }

    public int getCharacterId() {
        return characterId;
    }

    public void setCharacterId(int characterId) {
        this.characterId = characterId;
    }
}
