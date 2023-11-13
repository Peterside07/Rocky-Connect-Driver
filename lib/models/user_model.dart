

import 'dart:convert';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    int? userId;
    String? firstName;
    String? lastName;
    String? phoneNumber;
    String? password;
    String? email;
    int? role;
    int? accountVerified;
    bool? isAccountActive;
    DateTime? dateCreated;
    DateTime? dateUpdated;
    DateTime? dateVerified;

    UserModel({
        this.userId,
        this.firstName,
        this.lastName,
        this.phoneNumber,
        this.password,
        this.email,
        this.role,
        this.accountVerified,
        this.isAccountActive,
        this.dateCreated,
        this.dateUpdated,
        this.dateVerified,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json["userID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        email: json["email"],
        role: json["role"],
        accountVerified: json["accountVerified"],
        isAccountActive: json["isAccountActive"],
        dateCreated: DateTime.parse(json["date_Created"]),
        dateUpdated: DateTime.parse(json["date_Updated"]),
        dateVerified: DateTime.parse(json["date_Verified"]),
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "password": password,
        "email": email,
        "role": role,
        "accountVerified": accountVerified,
        "isAccountActive": isAccountActive,
        "date_Created": dateCreated!.toIso8601String(),
        "date_Updated": dateUpdated!.toIso8601String(),
        "date_Verified": dateVerified!.toIso8601String(),
    };
}
