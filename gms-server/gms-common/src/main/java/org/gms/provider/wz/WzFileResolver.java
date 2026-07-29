package org.gms.provider.wz;

import org.gms.property.ServiceProperty;
import org.springframework.stereotype.Service;

import java.nio.file.Files;
import java.nio.file.Path;

/**
 * wz文件解析
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/29 09:46
 */
@Service
public class WzFileResolver {

    private final ServiceProperty serviceProperty;

    public WzFileResolver(ServiceProperty serviceProperty) {
        this.serviceProperty = serviceProperty;
    }

    public Path getFile(WzFiles wzFile) {
        Path wzPath = Path.of(WzFiles.DIRECTORY, wzFile.getFileName());
        Path langPath = Path.of(WzFiles.DIRECTORY + "-" + serviceProperty.getLanguage(), wzFile.getFileName());

        return Files.exists(langPath) ? langPath : wzPath;
    }
}
