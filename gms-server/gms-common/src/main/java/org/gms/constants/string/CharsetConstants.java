/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package org.gms.constants.string;
import lombok.Getter;
import org.gms.property.ServiceProperty;
import org.springframework.stereotype.Component;

import java.nio.charset.Charset;
import java.util.Locale;

/**
 * 更新成springboot管理注入
 * @dwang
 */
@Component
public class CharsetConstants {

    private static Language serviceLanguage;

    // 使用构造器注入 ServiceProperty，Spring 会保证在容器启动时按顺序注入，绝不会 NPE
    public CharsetConstants(ServiceProperty serviceProperty) {
        CharsetConstants.serviceLanguage = parseServiceLanguage(serviceProperty.getLanguage());
    }

    public static Charset getCharset(int language) {
        return Charset.forName(Language.fromLang(language).getCharset());
    }

    public static Locale getLanguageLocale(int language) {
        return Locale.forLanguageTag(Language.fromLang(language).getLanguageTag());
    }

    public static boolean isZhCN() {
        return Language.LANGUAGE_CN == serviceLanguage;
    }

    private static Language parseServiceLanguage(String language) {
        if ("zh-CN".equals(language)) {
            return Language.LANGUAGE_CN;
        } else {
            return Language.LANGUAGE_US;
        }
    }

    /**
     * @see LanguageConstants
     */
    @Getter
    private enum Language {
        LANGUAGE_US(2, "US-ASCII", "en-US"),
        LANGUAGE_CN(3, "GBK", "zh-CN"),
        LANGUAGE_PT_BR(-1, "ISO-8859-1", "en-US"),
        LANGUAGE_THAI(-1, "TIS620", "th-TH"),
        LANGUAGE_KOREAN(-1, "MS949", "ko-KR");

        private final int lang;
        private final String charset;
        private final String languageTag;

        Language(int lang, String charset, String languageTag) {
            this.lang = lang;
            this.charset = charset;
            this.languageTag = languageTag;
        }

        public static Language fromLang(int lang) {
            for (Language value : values()) {
                if (value.getLang() == lang) {
                    return value;
                }
            }
            return serviceLanguage;
        }
    }
}