import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../models/otp_model.dart';

class PhoneOtpRepository {
  Future<Either<OtpM, OtpM>> fetchDataFromApi() async {
    // bool _hasInternet = await hasInternet();
    // if (!_hasInternet) {
    //   return Left(OtpM());
    // }
    EasyLoading.show();
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'https://mocki.io/v1/9a3d57b9-fa3f-402e-99f9-982134108d18'));

      http.StreamedResponse response = await request.send();
      var body = await response.stream.bytesToString();
      OtpModel data = otpModelFromJson(body);
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        return Right(OtpM(otp: data.otpCode,statusCode: response.statusCode));
      } else {
        return Left(OtpM(statusCode: response.statusCode));
      }
    } on SocketException catch (_) {
      EasyLoading.showError('No Internet Connection');
      return Left(OtpM(statusCode: 500));
    } catch (_) {
      EasyLoading.showError('Something went wrong');
      return Left(OtpM(statusCode: 500));
    }
  }
}

class OtpM {
  int? otp;
  int? statusCode;
  OtpM({this.otp, this.statusCode});
}
