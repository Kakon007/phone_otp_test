import 'package:flutter/material.dart';
import '../repositories/phone_otp_repository.dart';

class OtpProvider extends ChangeNotifier {
  bool _isFetchingMoreData = false;
  bool _isFetchingData = false;
  int? otp;
  int? getStatusCode;

  void reload() => notifyListeners();

  set isFetchingMoreData(bool value) {
    _isFetchingMoreData = value;
    notifyListeners();
  }

  Future<bool> getData() async {
    _isFetchingData = true;
    var res = await PhoneOtpRepository().fetchDataFromApi();
    notifyListeners();
    res.fold((l) {
      getStatusCode = l.statusCode;
      _isFetchingData = false;
      notifyListeners();
      return false;
    }, (r) {
      _isFetchingData = false;
      otp = r.otp;
      getStatusCode = r.statusCode;
      notifyListeners();
      return true;
    });
    return true;
  }

  bool get isFetchingData => _isFetchingData;
  bool get isFetchingMoreData => _isFetchingMoreData;
}
