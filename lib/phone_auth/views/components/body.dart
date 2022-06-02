import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../components/alternative_way_text.dart';
import '../../../components/constants.dart';
import '../../../components/design_button.dart';
import '../../../components/helper.dart';
import '../../../components/size_config.dart';
import '../../view_models/otp_provider.dart';
import 'otp_field_style.dart';
import 'otp_text_field.dart';

class Body extends StatefulWidget {
  const Body(
      {Key? key,
      required this.name,
      required this.phoneNumber,
      required this.createdAt,
      // required this.otp,
      required this.countyCode})
      : super(key: key);

  final String phoneNumber;
  final String name;
  final DateTime createdAt;
  //final String otp;
  final String? countyCode;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? pin;
  @override
  void initState() {
    var otpProvider = Provider.of<OtpProvider>(context, listen: false);
    otpProvider.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var otpProvider = Provider.of<OtpProvider>(context);
    return SizedBox(
      height: ScreenSize.height,
      width: ScreenSize.width,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: mainCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            color: Colors.white),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: kIconSize,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: kColPadding / 10),
              FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('assets/images/ph.png'),
              ),
              SizedBox(height: kColPadding / 10),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                    text: "Verification Code",
                    style: TextStyle(
                      color: Color(0xFF2DBC77),
                      fontSize: kFontSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [],
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: const TextSpan(
                  text: 'Please enter the ',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: kFontSize + 1,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '5-Digit ',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: kFontSize + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Code That send to',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: kFontSize + 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Text("${widget.countyCode}${widget.phoneNumber}"),
              const SizedBox(height: 10.0),
              StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Text(
                    Helper()
                        .liveRestTimer(dateTime: widget.createdAt, minLimit: 5),
                    style: const TextStyle(
                      color: kDefaultColor,
                      fontSize: kFontSize + 1.5,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
              const SizedBox(height: 8.0),
              OTPTextField(
                  length: 5,
                  otpFieldStyle: OtpFieldStyle(
                    backgroundColor: Colors.grey[200]!,
                    borderColor: Colors.white,
                  ),
                  width: ScreenSize.width - kRowPadding * 2,
                  fieldWidth: ScreenSize.width * 0.15 > 55
                      ? 55
                      : ScreenSize.width * 0.15,
                  style: const TextStyle(
                      fontSize: kFontSize * 1.5, fontWeight: FontWeight.w700),
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.box,
                  onCompleted: (_) {},
                  onChanged: (val) {
                    setState(() {
                      pin = val;
                    });
                  }),
              const SizedBox(height: 20.0),
              AlternativeWayText(
                  text: 'Code send, Try Again',
                  highlightText: 'Resend',
                  onTap: () {}),
              const SizedBox(height: 10.0),
              DesignButton(
                  width: ScreenSize.width * 0.8,
                  height: 38.0,
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kFontSize + 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: const Color(0xFF2DBC77),
                  onPressed: () async {
                    print(
                        "${otpProvider.getStatusCode} ${otpProvider.otp} $pin");
                    if (otpProvider.getStatusCode == 200 &&
                        otpProvider.otp == int.parse(pin!)) {
                      Navigator.pop(context);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
