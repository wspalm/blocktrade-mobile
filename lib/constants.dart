import 'package:flutter/material.dart';

import 'all_sign_form/size_config.dart';

const kPrimaryColor =
// Color(0xFFFF7643);
    Color(0xFF687A86);
// Color(0xFFD4D7D4);
// Color(0xFF868F74);
const kPrimaryLightColor =
// Color(0xFFFFECDF);
    Color(0xFFF3F7F8);
const kPrimaryGradientColor = LinearGradient(
  colors: [Color(0xFFFFA53E), Color(0xFF7643)],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const kSecondartColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

//Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]\d{2}+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp actNoValidatorRegExp = RegExp(r"^(\d{6})[-,-](\d{1})$");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Password doesn't match";

const String kPinNullError = "Please Enter your pin";

const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

const String kUsernameNullError = "Please Enter your username";

const String kActNoNullError = "Please Enter your Account No.";
const String kInvalidActNoError = "Please Enter Valid Account No.";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  enabledBorder: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  border: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kTextColor),
  );
}
