// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? password;
    String? email;
    String? deviceId;
    int? role;
    int? accountVerified;
    bool? isAccountActive;
    DateTime? dateCreated;
    DateTime? dateUpdated;
    DateTime? dateVerified;

    UserModel({
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.password,
        this.email,
        this.deviceId,
        this.role,
        this.accountVerified,
        this.isAccountActive,
        this.dateCreated,
        this.dateUpdated,
        this.dateVerified,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        email: json["email"],
        deviceId: json["deviceID"],
        role: json["role"],
        accountVerified: json["accountVerified"],
        isAccountActive: json["isAccountActive"],
        dateCreated: json["date_Created"] == null ? null : DateTime.parse(json["date_Created"]),
        dateUpdated: json["date_Updated"] == null ? null : DateTime.parse(json["date_Updated"]),
        dateVerified: json["date_Verified"] == null ? null : DateTime.parse(json["date_Verified"]),
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "password": password,
        "email": email,
        "deviceID": deviceId,
        "role": role,
        "accountVerified": accountVerified,
        "isAccountActive": isAccountActive,
        "date_Created": dateCreated?.toIso8601String(),
        "date_Updated": dateUpdated?.toIso8601String(),
        "date_Verified": dateVerified?.toIso8601String(),
    };
}
