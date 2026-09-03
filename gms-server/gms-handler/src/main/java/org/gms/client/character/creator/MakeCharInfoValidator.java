package org.gms.client.character.creator;

import org.gms.client.Character;
import org.gms.client.Job;
import org.gms.client.inventory.InventoryType;
import org.gms.provider.Data;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.wz.WzFiles;

public class MakeCharInfoValidator {
    private static final MakeCharInfoData charFemale;
    private static final MakeCharInfoData charMale;
    private static final MakeCharInfoData orientCharFemale;
    private static final MakeCharInfoData orientCharMale;
    private static final MakeCharInfoData premiumCharFemale;
    private static final MakeCharInfoData premiumCharMale;

    static {
        Data data = DataProviderFactory.getDataProvider(WzFiles.ETC).getData("MakeCharInfo.img");
        charFemale = new MakeCharInfoData(data.getChildByPath("Info/CharFemale"));
        charMale = new MakeCharInfoData(data.getChildByPath("Info/CharMale"));
        orientCharFemale = new MakeCharInfoData(data.getChildByPath("OrientCharFemale"));
        orientCharMale = new MakeCharInfoData(data.getChildByPath("OrientCharMale"));
        premiumCharFemale = new MakeCharInfoData(data.getChildByPath("PremiumCharFemale"));
        premiumCharMale = new MakeCharInfoData(data.getChildByPath("PremiumCharMale"));
    }

    private static MakeCharInfoData getMakeCharInfo(Character character) {
        return switch (character.getJob()) {
            case BEGINNER, WARRIOR, MAGICIAN, BOWMAN, THIEF, PIRATE -> character.isMale() ? charMale : charFemale;
            case NOBLESSE -> character.isMale() ? premiumCharMale : premiumCharFemale;
            case LEGEND -> character.isMale() ? orientCharMale : orientCharFemale;
            default -> null;
        };
    }

    public static boolean isNewCharacterValid(Character character) {
        MakeCharInfoData makeCharInfoData = getMakeCharInfo(character);
        if (makeCharInfoData == null) return false;

        return verifyCharacter(makeCharInfoData, character);
    }


    public static boolean verifyFaceId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharFaces().contains(id);
    }

    public static boolean verifyHairId(MakeCharInfoData makeCharInfoData, int id) {
        if (id % 10 != 0) {
            return makeCharInfoData.getCharHairs().contains(id - (id % 10));
        }
        return makeCharInfoData.getCharHairs().contains(id);
    }

    public static boolean verifyHairColorId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharHairColors().contains(id % 10);
    }

    public static boolean verifySkinId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharSkins().contains(id);
    }

    public static boolean verifyTopId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharTops().contains(id);
    }

    public static boolean verifyBottomId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharBottoms().contains(id);
    }

    public static boolean verifyShoeId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharShoes().contains(id);
    }

    public static boolean verifyWeaponId(MakeCharInfoData makeCharInfoData, int id) {
        return makeCharInfoData.getCharWeapons().contains(id);
    }

    public static boolean verifyCharacter(MakeCharInfoData makeCharInfoData, Character character) {
        if (!verifyFaceId(makeCharInfoData, character.getFace())) return false;
        if (!verifyHairId(makeCharInfoData, character.getHair())) return false;
        if (!verifyHairColorId(makeCharInfoData, character.getHair())) return false;
        if (!verifySkinId(makeCharInfoData, character.getSkinColor().getId())) return false;

        // Here we only verify the equipment if the character that's being created is of type 'Beginner'
        // This is because when the Maple Life A or Maple Life B items are used, the client does not send any data
        // regarding what equipment the character should be wearing (as it's all handled server-side)
        Job characterJob = character.getJob();
        if (characterJob == Job.BEGINNER || characterJob == Job.NOBLESSE || characterJob == Job.LEGEND) {
            if (!verifyTopId(makeCharInfoData, character.getInventory(InventoryType.EQUIPPED).getItem((short) -5).getItemId()))
                return false;
            if (!verifyBottomId(makeCharInfoData, character.getInventory(InventoryType.EQUIPPED).getItem((short) -6).getItemId()))
                return false;
            if (!verifyShoeId(makeCharInfoData, character.getInventory(InventoryType.EQUIPPED).getItem((short) -7).getItemId()))
                return false;
            if (!verifyWeaponId(makeCharInfoData, character.getInventory(InventoryType.EQUIPPED).getItem((short) -11).getItemId()))
                return false;
        }

        return true;
    }
}
