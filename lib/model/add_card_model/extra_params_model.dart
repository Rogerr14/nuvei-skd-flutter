// To parse this JSON data, do
//
//     final extraParamsModel = extraParamsModelFromJson(jsonString);

import 'dart:convert';

ExtraParamsModel extraParamsModelFromJson(String str) => ExtraParamsModel.fromJson(json.decode(str));

String extraParamsModelToJson(ExtraParamsModel data) => json.encode(data.toJson());

class ExtraParamsModel {
    ThreeDs2Data? threeDs2Data;
    BrowserInfo? browserInfo;

    ExtraParamsModel({
        this.threeDs2Data,
        this.browserInfo,
    });

    factory ExtraParamsModel.fromJson(Map<String, dynamic> json) => ExtraParamsModel(
        threeDs2Data: json["threeDS2_data"] == null ? null : ThreeDs2Data.fromJson(json["threeDS2_data"]),
        browserInfo: json["browser_info"] == null ? null : BrowserInfo.fromJson(json["browser_info"]),
    );

    Map<String, dynamic> toJson() => {
        "threeDS2_data": threeDs2Data?.toJson(),
        "browser_info": browserInfo?.toJson(),
    };
}

class BrowserInfo {
    String? ip;
    String? language;
    bool? javaEnabled;
    bool? jsEnabled;
    int? colorDepth;
    int? screenHeight;
    int? screenWidth;
    int? timezoneOffset;
    String? userAgent;
    String? acceptHeader;

    BrowserInfo({
        this.ip,
        this.language,
        this.javaEnabled,
        this.jsEnabled,
        this.colorDepth,
        this.screenHeight,
        this.screenWidth,
        this.timezoneOffset,
        this.userAgent,
        this.acceptHeader,
    });

    factory BrowserInfo.fromJson(Map<String, dynamic> json) => BrowserInfo(
        ip: json["ip"],
        language: json["language"],
        javaEnabled: json["java_enabled"],
        jsEnabled: json["js_enabled"],
        colorDepth: json["color_depth"],
        screenHeight: json["screen_height"],
        screenWidth: json["screen_width"],
        timezoneOffset: json["timezone_offset"],
        userAgent: json["user_agent"],
        acceptHeader: json["accept_header"],
    );

    Map<String, dynamic> toJson() => {
        "ip": ip,
        "language": language,
        "java_enabled": javaEnabled,
        "js_enabled": jsEnabled,
        "color_depth": colorDepth,
        "screen_height": screenHeight,
        "screen_width": screenWidth,
        "timezone_offset": timezoneOffset,
        "user_agent": userAgent,
        "accept_header": acceptHeader,
    };
}

class ThreeDs2Data {
    String? termUrl;
    String? deviceType;

    ThreeDs2Data({
        this.termUrl,
        this.deviceType,
    });

    factory ThreeDs2Data.fromJson(Map<String, dynamic> json) => ThreeDs2Data(
        termUrl: json["term_url"],
        deviceType: json["device_type"],
    );

    Map<String, dynamic> toJson() => {
        "term_url": termUrl,
        "device_type": deviceType,
    };
}
