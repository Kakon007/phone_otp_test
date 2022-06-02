// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

OtpModel otpModelFromJson(String str) => OtpModel.fromJson(json.decode(str));

String otpModelToJson(OtpModel data) => json.encode(data.toJson());

class OtpModel {
    OtpModel({
        this.otpCode,
    });

    int? otpCode;

    factory OtpModel.fromJson(Map<String, dynamic> json) => OtpModel(
        otpCode: json["otp_code"] == null ? null : json["otp_code"],
    );

    Map<String, dynamic> toJson() => {
        "otp_code": otpCode == null ? null : otpCode,
    };
}
