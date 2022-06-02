import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../components/alternative_way_text.dart';
import '../../components/constants.dart';
import '../../components/design_button.dart';
import '../../components/size_config.dart';
import 'phone_otp_verification_screen.dart';

TextEditingController phnNameCntrlr = TextEditingController();
TextEditingController phnCntrlr = TextEditingController();
TextEditingController promoCodeCntrlr = TextEditingController();
late String countryCode;
final RegExp phoneValidatorRegExp =
    RegExp(r'^([0-9]{9})|([A-Za-z0-9._%\+\-]+@[a-z0-9.\-]+\.[a-z]{2,3})$');

class PhoneSignUp extends StatefulWidget {
  const PhoneSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneSignUp> createState() => _PhoneSignUpState();
}

class _PhoneSignUpState extends State<PhoneSignUp> {
  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    countryCode = '+880';
    return Padding(
      padding: const EdgeInsets.only(top: 40.0, left: 20, right: 20),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: mainCenter,
            mainAxisSize: mainMin,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        //Navigator.pop(context);
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
              SizedBox(height: kColPadding / 7),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  text: const TextSpan(
                    text: "Test Task",
                    style: TextStyle(
                      color: Color(0xFF2DBC77),
                      fontSize: kFontSize * 2.5,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [],
                  ),
                ),
              ),
              SizedBox(height: kColPadding),
              SizedBox(
                width: ScreenSize.width * 0.9,
                child: const Text('Phone Number'),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: CountryCodePicker(
                                onChanged: (v) {
                                  countryCode = v.dialCode!;
                                },
                                padding: const EdgeInsets.all(0.0),
                                textStyle: const TextStyle(
                                  fontSize: kFontSize + 2,
                                  color: Colors.black,
                                ),
                                showFlagMain: false,
                                alignLeft: true,
                                searchDecoration: const InputDecoration(
                                  hintText: 'Search',
                                ),
                                dialogSize: Size(ScreenSize.width * 0.9,
                                    ScreenSize.height * 0.9),
                                initialSelection: 'BD',
                                favorite: const ['+880', 'BD'],
                              ),
                            ),
                            const Expanded(
                                flex: 1, child: Icon(Icons.arrow_drop_down))
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: kRowPadding),
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone Number',
                            errorStyle:
                                const TextStyle(fontWeight: FontWeight.w500),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.phone, size: kIconSize),
                              color: kDefaultColor,
                              onPressed: () {},
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                          controller: phnCntrlr,
                          validator: (phn) {
                            if (phn == '') {
                              return 'Please Enter Your Phone Number';
                            } else if (!phoneValidatorRegExp.hasMatch(phn!)) {
                              return 'Please Enter A Valid Number';
                            } else if (phn.length > 11) {
                              return 'Please Enter A Valid Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              CheckboxListTile(
                activeColor: const Color(0xFF2DBC77),
                title: RichText(
                  text: const TextSpan(
                    text: "You agree to our ",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: TextStyle(
                          color: Color(0xFF2DBC77),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                value: checkedValue,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 20.0),
              DesignButton(
                  width: ScreenSize.width * 0.8,
                  height: 38.0,
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: kFontSize + 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  color: const Color(0xFF2DBC77),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print('Pressed');
                      Navigator.push(
                        context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: PhoneVerification(
                          countyCode: countryCode,
                          //otp: PhoneSignUpPostM.otp!,
                          name: phnNameCntrlr.text,
                          phoneNumber: phnCntrlr.text,
                          createdAt: DateTime.now(),
                        ),
                      ),
                      );
                    }
                  }),
              const SizedBox(height: 10.0),
              AlternativeWayText(
                  text: 'Don\'t Have An Account?',
                  highlightText: 'Sign Up',
                  onTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
