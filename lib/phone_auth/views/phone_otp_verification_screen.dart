import 'package:flutter/material.dart';

import 'components/body.dart';

class PhoneVerification extends StatelessWidget {
  const PhoneVerification({
    Key? key,
    required this.phoneNumber,
    required this.name,
    required this.createdAt,
    //required this.otp,
    required this.countyCode
  }) : super(key: key);

  final String phoneNumber;
  final String name;
  final DateTime createdAt;
  //final String otp;
  final String? countyCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Body(countyCode: countyCode,name: name,phoneNumber: phoneNumber, createdAt: createdAt));
  }
}
