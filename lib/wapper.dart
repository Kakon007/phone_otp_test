import 'package:flutter/material.dart';

import 'components/size_config.dart';
import 'phone_auth/views/phone_sign_up_screen.dart';



class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenSize().init(context);
    return const Scaffold(body: PhoneSignUp());
  }
}
