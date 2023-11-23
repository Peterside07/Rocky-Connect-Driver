// To parse this JSON data, do
//
//     final tripResponse = tripResponseFromJson(jsonString);

import 'dart:convert';

TripResponse tripResponseFromJson(String str) => TripResponse.fromJson(json.decode(str));

String tripResponseToJson(TripResponse data) => json.encode(data.toJson());

class TripResponse {
    String? id;
    String? customerEmail;
    String? driverEmail;
    String? destination;
    String? sourceLocation;
    String? sourceLongitude;
    String? sourceLatitude;
    String? destinationLong;
    String? destinationLat;
    dynamic destinationState;
    int? tripDistance;
    int? tripCost;
    String? tripInitiator;
    dynamic paymentId;
    String? tripStatus;
    dynamic cancelReason;
    int? totalTime;
    DateTime? tripDate;
    String? driverFirstName;
    String? driverLastName;
    String? driverPhoneNumber;
    String? riderFirstName;
    String? riderLastName;
    String? riderPhoneNumber;
    int? rating;
    int? noOfRides;
    String? carMake;
    String? carModel;
    String? carColor;
    String? plateNumber;
    String? typeOfVehicle;
    String? driverLiscense;
    String? carPreferences;
    String? deviceId;

    TripResponse({
        this.id,
        this.customerEmail,
        this.driverEmail,
        this.destination,
        this.sourceLocation,
        this.sourceLongitude,
        this.sourceLatitude,
        this.destinationLong,
        this.destinationLat,
        this.destinationState,
        this.tripDistance,
        this.tripCost,
        this.tripInitiator,
        this.paymentId,
        this.tripStatus,
        this.cancelReason,
        this.totalTime,
        this.tripDate,
        this.driverFirstName,
        this.driverLastName,
        this.driverPhoneNumber,
        this.riderFirstName,
        this.riderLastName,
        this.riderPhoneNumber,
        this.rating,
        this.noOfRides,
        this.carMake,
        this.carModel,
        this.carColor,
        this.plateNumber,
        this.typeOfVehicle,
        this.driverLiscense,
        this.carPreferences,
        this.deviceId,
    });

    factory TripResponse.fromJson(Map<String, dynamic> json) => TripResponse(
        id: json["id"],
        customerEmail: json["customerEmail"],
        driverEmail: json["driverEmail"],
        destination: json["destination"],
        sourceLocation: json["sourceLocation"],
        sourceLongitude: json["sourceLongitude"],
        sourceLatitude: json["sourceLatitude"],
        destinationLong: json["destinationLong"],
        destinationLat: json["destinationLat"],
        destinationState: json["destinationState"],
        tripDistance: json["tripDistance"],
        tripCost: json["tripCost"],
        tripInitiator: json["tripInitiator"],
        paymentId: json["paymentID"],
        tripStatus: json["tripStatus"],
        cancelReason: json["cancelReason"],
        totalTime: json["totalTime"],
        tripDate: json["tripDate"] == null ? null : DateTime.parse(json["tripDate"]),
        driverFirstName: json["driverFirstName"],
        driverLastName: json["driverLastName"],
        driverPhoneNumber: json["driverPhoneNumber"],
        riderFirstName: json["riderFirstName"],
        riderLastName: json["riderLastName"],
        riderPhoneNumber: json["riderPhoneNumber"],
        rating: json["rating"],
        noOfRides: json["noOfRides"],
        carMake: json["carMake"],
        carModel: json["carModel"],
        carColor: json["carColor"],
        plateNumber: json["plateNumber"],
        typeOfVehicle: json["typeOfVehicle"],
        driverLiscense: json["driverLiscense"],
        carPreferences: json["carPreferences"],
        deviceId: json["deviceID"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "customerEmail": customerEmail,
        "driverEmail": driverEmail,
        "destination": destination,
        "sourceLocation": sourceLocation,
        "sourceLongitude": sourceLongitude,
        "sourceLatitude": sourceLatitude,
        "destinationLong": destinationLong,
        "destinationLat": destinationLat,
        "destinationState": destinationState,
        "tripDistance": tripDistance,
        "tripCost": tripCost,
        "tripInitiator": tripInitiator,
        "paymentID": paymentId,
        "tripStatus": tripStatus,
        "cancelReason": cancelReason,
        "totalTime": totalTime,
        "tripDate": tripDate?.toIso8601String(),
        "driverFirstName": driverFirstName,
        "driverLastName": driverLastName,
        "driverPhoneNumber": driverPhoneNumber,
        "riderFirstName": riderFirstName,
        "riderLastName": riderLastName,
        "riderPhoneNumber": riderPhoneNumber,
        "rating": rating,
        "noOfRides": noOfRides,
        "carMake": carMake,
        "carModel": carModel,
        "carColor": carColor,
        "plateNumber": plateNumber,
        "typeOfVehicle": typeOfVehicle,
        "driverLiscense": driverLiscense,
        "carPreferences": carPreferences,
        "deviceID": deviceId,
    };
}
