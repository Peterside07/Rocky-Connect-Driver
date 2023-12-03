// To parse this JSON data, do
//
//     final driverModel = driverModelFromJson(jsonString);

import 'dart:convert';

DriverModel driverModelFromJson(String str) => DriverModel.fromJson(json.decode(str));

String driverModelToJson(DriverModel data) => json.encode(data.toJson());

class DriverModel {
    String? email;
    int? rating;
    int? noOfRides;
    String? carId;

    DriverModel({
        this.email,
        this.rating,
        this.noOfRides,
        this.carId,
    });

    factory DriverModel.fromJson(Map<String, dynamic> json) => DriverModel(
        email: json["email"],
        rating: json["rating"],
        noOfRides: json["noOfRides"],
        carId: json["carID"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "rating": rating,
        "noOfRides": noOfRides,
        "carID": carId,
    };
}
