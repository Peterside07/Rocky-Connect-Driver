// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'dart:convert';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

class CarModel {
    String? id;
    String? email;
    String? carMake;
    String? carModel;
    String? carColor;
    String? plateNumber;
    String? typeOfVehicle;
    String? driverLiscense;
    String? carPreferences;
    DateTime? dateCreated;
    DateTime? dateUpdated;

    CarModel({
        this.id,
        this.email,
        this.carMake,
        this.carModel,
        this.carColor,
        this.plateNumber,
        this.typeOfVehicle,
        this.driverLiscense,
        this.carPreferences,
        this.dateCreated,
        this.dateUpdated,
    });

    factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
        id: json["id"],
        email: json["email"],
        carMake: json["carMake"],
        carModel: json["carModel"],
        carColor: json["carColor"],
        plateNumber: json["plateNumber"],
        typeOfVehicle: json["typeOfVehicle"],
        driverLiscense: json["driverLiscense"],
        carPreferences: json["carPreferences"],
        dateCreated: json["date_Created"] == null ? null : DateTime.parse(json["date_Created"]),
        dateUpdated: json["date_Updated"] == null ? null : DateTime.parse(json["date_Updated"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "carMake": carMake,
        "carModel": carModel,
        "carColor": carColor,
        "plateNumber": plateNumber,
        "typeOfVehicle": typeOfVehicle,
        "driverLiscense": driverLiscense,
        "carPreferences": carPreferences,
        "date_Created": dateCreated?.toIso8601String(),
        "date_Updated": dateUpdated?.toIso8601String(),
    };
}
