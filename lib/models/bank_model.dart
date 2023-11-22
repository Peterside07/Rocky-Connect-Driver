// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
    String? email;
    String? accountNumber;
    String? routingNumber;
    String? bankName;

    BankModel({
        this.email,
        this.accountNumber,
        this.routingNumber,
        this.bankName,
    });

    factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        email: json["email"],
        accountNumber: json["accountNumber"],
        routingNumber: json["routingNumber"],
        bankName: json["bankName"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "accountNumber": accountNumber,
        "routingNumber": routingNumber,
        "bankName": bankName,
    };
}
