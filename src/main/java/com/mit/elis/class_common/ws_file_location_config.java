package com.mit.elis.class_common;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
@ConfigurationProperties(prefix = "file.upload")

public class ws_file_location_config {

    String tempfile_location;
    String pic_file_location;
    String jasper_report_file_location;
    String oblique_file_location;
    String soft_file_location;

}
