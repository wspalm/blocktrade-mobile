import 'dart:convert';

import 'package:blocktrade/all_sign_form/SignInForm/forget_password/forget_password_screen.dart';
import 'package:blocktrade/all_sign_form/SignInForm/login_success/login_success_screen.dart';
import 'package:blocktrade/all_sign_form/components/custom_surfix_icon.dart';
import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/components/form_error.dart';
import 'package:blocktrade/all_sign_form/components/no_account_text.dart';
import 'package:blocktrade/all_sign_form/components/social_card.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../store.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 120),
        child: Text(
          "Sign In",
        ),
      ),
    );
  }
} //ef

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight! * 0.04),
                Text(
                  "Welcome User",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Sign in with your username and password",
                    textAlign: TextAlign.center),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight! * 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
} //ef

class SignForm extends StatefulWidget {
  TextEditingController username_txt = new TextEditingController();
  TextEditingController password_txt = new TextEditingController();
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  //late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    Store mystore = Provider.of<Store>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildUsernameFormField(),
          //buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  }),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgetPasswordScreen.routeName),
                child: Text(
                  "Forget Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          Hero(
            tag: LoginSuccessScreen.routeName,
            child: DefaultButton(
              text: "Sign In",
              // press: () {
              //   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
              // },
              press: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  //if all are valid then go to success screen
                  //Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  //login(context);
                  String _username = widget.username_txt.text;
                  String _password = widget.password_txt.text;
                  String _url = 'http://192.168.1.41:8000/api/test_post/';
                  print(_username);
                  print(_password);
                  var param_map = {
                    'username': _username,
                    'password': _password
                  };
                  print(param_map);
                  var jsontxt = json.encode(param_map);
                  var response = await http.post(
                    Uri.parse(_url),
                    body: jsontxt,
                    headers: {'Content-Type': "application/json"},
                  );
                  var result_map = json.decode(response.body);
                  print(result_map);
                  if (result_map['status_code'] == 200) {
                    mystore.setValue(result_map['login_info'].toString());
                    print("This is the value that should be store --->> ");
                    print(mystore.customerUsername);
                    Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                  } //end of if
                  else if (result_map['status_code'] != 200) {
                    var message = result_map['message'];
                    _showDialog2(context, message);
                  } //end of else if
                } //end of outter if
              },
            ),
          ),
        ],
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue!,
      controller: widget.username_txt,
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Enter your username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue!,
      controller: widget.password_txt,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        //If you are using latest version of flutter then
        //lable textand hint text and text shown like this
        // if you r using flutter less than 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }
} //ef

void _showDialog2(BuildContext context, String return_message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Alert !!"),
        content: new Text(return_message),
        actions: <Widget>[
          TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
} //end of show dialog function


// class SignInScreen extends StatelessWidget {
//   static String routeName = "/sign_in";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar(),
//       body: Body(),
//     );
//   }
//   AppBar buildAppBar() {
//     return AppBar(
//       title: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 120),
//         child: Text(
//           "Sign In",
//         ),
//       ),
//     );
//   }
// } //ef

// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: double.infinity,
//         child: Padding(
//           padding:
//               EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 SizedBox(height: SizeConfig.screenHeight! * 0.04),
//                 Text(
//                   "Welcome Back",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: getProportionateScreenWidth(28),
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                     "Sign in with your email and password \nor continue with social media",
//                     textAlign: TextAlign.center),
//                 SizedBox(height: SizeConfig.screenHeight! * 0.08),
//                 SignForm(),
//                 SizedBox(height: SizeConfig.screenHeight! * 0.08),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SocialCard(
//                       icon: "assets/icons/google-icon.svg",
//                       press: () {},
//                     ),
//                     SocialCard(
//                       icon: "assets/icons/facebook-2.svg",
//                       press: () {},
//                     ),
//                     SocialCard(
//                       icon: "assets/icons/twitter.svg",
//                       press: () {},
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: getProportionateScreenHeight(20)),
//                 NoAccountText(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// } //ef

// class SignForm extends StatefulWidget {
//   @override
//   _SignFormState createState() => _SignFormState();
// }
// class _SignFormState extends State<SignForm> {
//   final _formKey = GlobalKey<FormState>();
//   late String username;
//   //late String email;
//   late String password;
//   bool remember = false;
//   final List<String> errors = [];
//   void addError({required String error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   }
//   void removeError({required String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildUsernameFormField(),
//           //buildEmailFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPasswordFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           Row(
//             children: [
//               Checkbox(
//                   value: remember,
//                   activeColor: kPrimaryColor,
//                   onChanged: (value) {
//                     setState(() {
//                       remember = value!;
//                     });
//                   }),
//               Text("Remember me"),
//               Spacer(),
//               GestureDetector(
//                 onTap: () => Navigator.pushNamed(
//                     context, ForgetPasswordScreen.routeName),
//                 child: Text(
//                   "Forget Password",
//                   style: TextStyle(decoration: TextDecoration.underline),
//                 ),
//               ),
//             ],
//           ),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(20)),
//           Hero(
//             tag: LoginSuccessScreen.routeName,
//             child: DefaultButton(
//               text: "Continue",
//               press: () {
//                 if (_formKey.currentState!.validate()) {
//                   _formKey.currentState!.save();
//                   //if all are valid then go to success screen
//                   Navigator.pushNamed(context, LoginSuccessScreen.routeName);
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => password = newValue!,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPassNullError);
//         } else if (value.length >= 8) {
//           removeError(error: kShortPassError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPassNullError);
//           return "";
//         } else if (value.length < 8) {
//           addError(error: kShortPassError);
//           return "";
//         }
//         return null;
//       },
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         labelText: "Password",
//         hintText: "Enter your password",
//         //If you are using latest version of flutter then
//         //lable textand hint text and text shown like this
//         // if you r using flutter less than 1.20.* then maybe this is not working properly
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(
//           svgIcon: "assets/icons/Lock.svg",
//         ),
//       ),
//     );
//   }
//   TextFormField buildUsernameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => username = newValue!,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kUsernameNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kUsernameNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Username",
//         hintText: "Enter your username",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }
//   // TextFormField buildEmailFormField() {
//   //   return TextFormField(
//   //     onSaved: (newValue) => email = newValue!,
//   //     keyboardType: TextInputType.emailAddress,
//   //     onChanged: (value) {
//   //       if (value.isNotEmpty) {
//   //         removeError(error: kEmailNullError);
//   //       } else if (emailValidatorRegExp.hasMatch(value)) {
//   //         removeError(error: kInvalidEmailError);
//   //       }
//   //       return null;
//   //     },
//   //     validator: (value) {
//   //       if (value!.isEmpty) {
//   //         addError(error: kEmailNullError);
//   //         return "";
//   //       } else if (!emailValidatorRegExp.hasMatch(value)) {
//   //         addError(error: kInvalidEmailError);
//   //         return "";
//   //       }
//   //       return null;
//   //     },
//   //     decoration: InputDecoration(
//   //       labelText: "Email",
//   //       hintText: "Enter your email",
//   //       //If you are using latest version of flutter then
//   //       //lable textand hint text and text shown like this
//   //       // if you r using flutter less than 1.20.* then maybe this is not working properly
//   //       floatingLabelBehavior: FloatingLabelBehavior.always,
//   //       suffixIcon: CustomSurffixIcon(
//   //         svgIcon: "assets/icons/Mail.svg",
//   //       ),
//   //     ),
//   //   );
//   // }
// }//ef
