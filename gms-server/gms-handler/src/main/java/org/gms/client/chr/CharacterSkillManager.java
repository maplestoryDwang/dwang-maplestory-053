package org.gms.client.chr;

/**
 * 6. CharacterSkillManager – 技能/冷却/龙/宏
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:38
 */

import org.gms.client.Character;
import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class CharacterSkillManager {

    private final Character parent;

    public CharacterSkillManager(Character parent) {
        this.parent = parent;
    }
}