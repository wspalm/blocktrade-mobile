import 'package:blocktrade/all_sign_form/splash/splash_screen.dart';
import 'package:blocktrade/main.dart';
import 'package:blocktrade/screen/order_page.dart';
import 'package:blocktrade/screen/portfolio_page.dart';
import 'package:flutter/material.dart';

import 'SignInForm/forget_password/forget_password_screen.dart';
import 'SignInForm/login_success/login_success_screen.dart';
import 'SignInForm/sign_in/sign_in_screen.dart';
import 'SignUpForm/sign_up/complete_profile_screen.dart';
import 'SignUpForm/otp/otp_screen.dart';
import 'SignUpForm/sign_up/sign_up_screen.dart';
import 'SignUpForm/signup_success/signup_success_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgetPasswordScreen.routeName: (context) => ForgetPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  SignUpSuccessScreen.routeName: (context) => SignUpSuccessScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routename: (context) => OtpScreen(),
  HomePage.routeName: (context) => HomePage(),
  OrderSuccessScreen.routeName: (context) => OrderSuccessScreen(),
  Tab1.routeName: (context) => Tab1(),
  // HomeScreen.routeName: (context) => HomeScreen(),
  // DetailsScreen.routeName: (context) => DetailsScreen(),
  // CartScreen.routeName: (context) => CartScreen(),
  // ProfileScreen.routeName: (context) => ProfileScreen(),
};
