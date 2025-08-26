// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String email;
  String? ipAddress;
  String? phone;
  String? firstName;
  String? lastName;
  String? fiscalNumber;
  String? fiscalNumberType;
  String? zip;
  String? city;
  String? address;
  String? country;
  String? state;
  String? identification;

  UserModel({
    required this.id,
    required this.email,
    this.ipAddress,
    this.phone,
    this.firstName,
    this.lastName,
    this.fiscalNumber,
    this.fiscalNumberType,
    this.zip,
    this.city,
    this.address,
    this.country,
    this.state,
    this.identification,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    email: json["email"],
    ipAddress: json["ip_address"],
    phone: json["phone"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    fiscalNumber: json["fiscal_number"],
    fiscalNumberType: json["fiscal_number_type"],
    zip: json["zip"],
    city: json["city"],
    address: json["address"],
    country: json["country"],
    state: json["state"],
    identification: json["identification"],
  );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {"email": email, "id": id};
    if (ipAddress != null) data["ip_address"] = ipAddress;
    if (ipAddress != null) data["phone"] = phone;
    if (firstName != null) data["first_name"] = firstName;
    if (lastName != null) data["last_name"] = lastName;
    if (fiscalNumber != null) data["fiscal_number"] = fiscalNumber;
    if (fiscalNumberType != null) data["fiscal_number_type"] = fiscalNumberType;
    if (zip != null) data["zip"] = zip;
    if (city != null) data["city"] = city;
    if (address != null) data["address"] = address;
    if (country != null) data["country"] = country;
    if (state != null) data["state"] = state;
    if (identification != null) data["identification"] = identification;
    return data;
  }
}
