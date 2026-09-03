package org.gms.client.character.creator;

import lombok.Getter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.gms.provider.Data;
import org.gms.provider.DataTool;

import java.util.HashSet;
import java.util.Set;

/* *
 * 创建角色提供类
 *
 * @author Dwang
 * @since 2026-09-03 12:28
 * @param null
 * @return
 */
@Getter
public class MakeCharInfoData {
    private static final Logger log = LoggerFactory.getLogger(MakeCharInfoData.class);
    private static final String FACE_ID = "0";
    private static final String HAIR_ID = "1";
    private static final String HAIR_COLOR_ID = "2";
    private static final String SKIN_ID = "3";
    private static final String TOP_ID = "4";
    private static final String BOTTOM_ID = "5";
    private static final String SHOE_ID = "6";
    private static final String WEAPON_ID = "7";

    private final Set<Integer> charFaces = new HashSet<>();
    private final Set<Integer> charHairs = new HashSet<>();
    private final Set<Integer> charHairColors = new HashSet<>();
    private final Set<Integer> charSkins = new HashSet<>();
    private final Set<Integer> charTops = new HashSet<>();
    private final Set<Integer> charBottoms = new HashSet<>();
    private final Set<Integer> charShoes = new HashSet<>();
    private final Set<Integer> charWeapons = new HashSet<>();


    public MakeCharInfoData(Data charInfoData) {
        for (Data data : charInfoData.getChildren()) {
            switch (data.getName()) {
                case FACE_ID -> {
                    for (Data faceData : data) {
                        charFaces.add(DataTool.getInt(faceData));
                    }
                }
                case HAIR_ID -> {
                    for (Data hairData : data) {
                        charHairs.add(DataTool.getInt(hairData));
                    }
                }
                case HAIR_COLOR_ID -> {
                    for (Data hairColorData : data) {
                        charHairColors.add(DataTool.getInt(hairColorData));
                    }
                }
                case SKIN_ID -> {
                    for (Data skinData : data) {
                        charSkins.add(DataTool.getInt(skinData));
                    }
                }
                case TOP_ID -> {
                    for (Data topData : data) {
                        charTops.add(DataTool.getInt(topData));
                    }
                }
                case BOTTOM_ID -> {
                    for (Data bottomData : data) {
                        charBottoms.add(DataTool.getInt(bottomData));
                    }
                }
                case SHOE_ID -> {
                    for (Data shoeData : data) {
                        charShoes.add(DataTool.getInt(shoeData));
                    }
                }
                case WEAPON_ID -> {
                    for (Data weaponData : data) {
                        charWeapons.add(DataTool.getInt(weaponData));
                    }
                }
                default -> log.error("Unhandled node inside MakeCharInfo.img.xml: '" + data.getName() + "'");
            }
        }
    }


}
