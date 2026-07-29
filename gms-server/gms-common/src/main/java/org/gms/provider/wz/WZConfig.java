package org.gms.provider.wz;

import java.text.NumberFormat;
import java.util.Locale;

/**
 * wz解析config
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/29 10:10
 */
public class WZConfig {

    // 'use_unit_price_with_comma', 'true',
    // 解析wz时支持用逗号加点分隔的数字，如12,345.67能解析成12345.67
    // (Set this accordingly with the layout of the unitPrices on Item.wz XML''s, whether it''s using commas or dots to represent fractions.)'),
    // NumberFormat.getInstance(GameConfig.getServerBoolean("use_unit_price_with_comma") ? Locale.FRANCE : Locale.UK);

//    Locale locale = Locale.FRANCE;  不使用
    private static Locale localeLanguage = Locale.UK;


    private final static NumberFormat nfParser = NumberFormat.getInstance(localeLanguage);

    public synchronized static Number parseNumber(String value) {
        try {
            return nfParser.parse(value);
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0f;
        }
    }
}
