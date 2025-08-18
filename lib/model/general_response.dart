import 'dart:convert';

GeneralResponse generalResponseFromJson(String str) => GeneralResponse.fromJson(json.decode(str));

String generalResponseToJson(GeneralResponse data) => json.encode(data.toJson());

class GeneralResponse<T> {
  GeneralResponse({
    this.data,
    required this.error,
  });

  T? data;
  bool error;

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
          data: json["data"],
          error: json["error"] ?? false);

  Map<String, dynamic> toJson() => {
        "data": data,
        "error": error
      };
}