import 'package:blocktrade/all_sign_form/SignUpForm/sign_up/complete_profile_screen.dart';
import 'package:blocktrade/all_sign_form/components/custom_surfix_icon.dart';
import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/components/form_error.dart';
import 'package:blocktrade/all_sign_form/components/social_card.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/constants.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import './signup.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/sign_up";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 120),
          child: Text("Sign Up"),
        ),
      ),
      body: Body(),
    );
  }
} //ef

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.02), //2%
              Text(
                "Register Account",
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.07),
              SignUpForm(),
              SizedBox(height: SizeConfig.screenHeight! * 0.07),
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
              Text(
                "By continuing your confirm that you agree \nwith our Term and Condition",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
} //ef

class SignUpForm extends StatefulWidget {
  TextEditingController username_txt = new TextEditingController();
  TextEditingController password_txt = new TextEditingController();

  TextEditingController confirmpassword_txt = new TextEditingController();
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late String username;

  late String password;
  late String confirmpassword;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  } //ef

  void removeError({required String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  } //ef

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //buildEmailFormField(),
          //SizedBox(height: getProportionateScreenHeight(30)),
          buildUsernameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                //Go to complete profile page
                // var CompleteProfileScreen;
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                //var completeProfileScreen;
                // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                get_ready(context);
              }
            },
          ),
        ],
      ),
    );
  } //ew

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue!,
      controller: widget.username_txt,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kUsernameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kUsernameNullError);
          return "";
        }
        return null;
      },
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
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        }
        //  else if (value.length >= 8) {
        //   removeError(error: kShortPassError);
        // }
        password = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        }
        // else if (value.length < 8) {
        //   addError(error: kShortPassError);
        //   return "";
        // }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
        ),
      ),
    );
  }

  TextFormField buildConfPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => confirmpassword = newValue!,
      controller: widget.confirmpassword_txt,
      onChanged: (value) {
        if (password == confirmpassword) {
          removeError(error: kMatchPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        } else if (password != value) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  void get_ready(BuildContext context) {
    String _username = widget.username_txt.text;
    String _password = widget.password_txt.text;
    String _con_password = widget.confirmpassword_txt.text;

    sending_obj['username'] = _username;
    sending_obj['password'] = _password;
    sending_obj['confirm_password'] = _con_password;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CompleteProfileScreen()),
    );
  } //end of get ready function

}//ef


// class SignUpScreen extends StatelessWidget {
//   static String routeName = "/sign_up";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 120),
//           child: Text("Sign Up"),
//         ),
//       ),
//       body: Body(),
//     );
//   }
// } //ef

// class Body extends StatelessWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: Padding(
//         padding:
//             EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: SizeConfig.screenHeight! * 0.02), //2%
//               Text(
//                 "Register Account",
//                 style: headingStyle,
//               ),
//               Text(
//                 "Complete your details or continue \nwith social media",
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: SizeConfig.screenHeight! * 0.07),
//               SignUpForm(),
//               SizedBox(height: SizeConfig.screenHeight! * 0.07),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SocialCard(
//                     icon: "assets/icons/google-icon.svg",
//                     press: () {},
//                   ),
//                   SocialCard(
//                     icon: "assets/icons/facebook-2.svg",
//                     press: () {},
//                   ),
//                   SocialCard(
//                     icon: "assets/icons/twitter.svg",
//                     press: () {},
//                   ),
//                 ],
//               ),
//               SizedBox(height: getProportionateScreenHeight(20)),
//               Text(
//                 "By continuing your confirm that you agree \nwith our Term and Condition",
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// } //ef

// class SignUpForm extends StatefulWidget {
//   TextEditingController email_txt = new TextEditingController();
//   TextEditingController username_txt = new TextEditingController();
//   TextEditingController password_txt = new TextEditingController();

//   TextEditingController confirmpassword_txt = new TextEditingController();
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }

// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   late String username;
//   late String email;
//   late String password;
//   late String confirmpassword;
//   final List<String> errors = [];

//   // void addError({required String error}) {
//   //   if (!errors.contains(error))
//   //     setState(() {
//   //       errors.add(error);
//   //     });
//   // } //ef

//   // void removeError({required String error}) {
//   //   if (errors.contains(error))
//   //     setState(() {
//   //       errors.remove(error);
//   //     });
//   // } //ef

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildEmailFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildUsernameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPasswordFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildConfPasswordFormField(),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           DefaultButton(
//             text: "Continue",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 //Go to complete profile page
//                 // var CompleteProfileScreen;
//                 // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
//                 //var completeProfileScreen;
//                 // Navigator.pushNamed(context, CompleteProfileScreen.routeName);
//                 signUp(context);
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   } //ew

//   TextFormField buildUsernameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => username = newValue!,
//       controller: widget.username_txt,
//       decoration: InputDecoration(
//         labelText: "Username",
//         hintText: "Enter your username",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }

//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => password = newValue!,
//       controller: widget.password_txt,
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         labelText: "Password",
//         hintText: "Enter your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(
//           svgIcon: "assets/icons/Lock.svg",
//         ),
//       ),
//     );
//   }

//   TextFormField buildConfPasswordFormField() {
//     return TextFormField(
//       obscureText: true,
//       onSaved: (newValue) => confirmpassword = newValue!,
//       // onChanged: (value) {
//       //   if (password == confirmpassword) {
//       //     removeError(error: kMatchPassError);
//       //   }
//       //   return null;
//       // },
//       // validator: (value) {
//       //   if (value!.isEmpty) {
//       //     return "";
//       //   } else if (password != value) {
//       //     addError(error: kMatchPassError);
//       //     return "";
//       //   }
//       //   return null;
//       // },
//       decoration: InputDecoration(
//         labelText: "Confirm Password",
//         hintText: "Re-enter your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//       ),
//     );
//   }

//   TextFormField buildEmailFormField() {
//     return TextFormField(
//       onSaved: (newValue) => email = newValue!,
//       controller: widget.email_txt,
//       keyboardType: TextInputType.emailAddress,
//       // onChanged: (value) {
//       //   if (value.isNotEmpty) {
//       //     removeError(error: kEmailNullError);
//       //   } else if (emailValidatorRegExp.hasMatch(value)) {
//       //     removeError(error: kInvalidEmailError);
//       //   }
//       //   return null;
//       // },
//       // validator: (value) {
//       //   if (value!.isEmpty) {
//       //     addError(error: kEmailNullError);
//       //     return "";
//       //   } else if (!emailValidatorRegExp.hasMatch(value)) {
//       //     addError(error: kInvalidEmailError);
//       //     return "";
//       //   }
//       //   return null;
//       // },
//       decoration: InputDecoration(
//         labelText: "Email",
//         hintText: "Enter your email",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(
//           svgIcon: "assets/icons/Mail.svg",
//         ),
//       ),
//     );
//   } //ef

//   void signUp(BuildContext context) async {
//     String _email = widget.email_txt.text;
//     String _username = widget.username_txt.text;
//     String _password = widget.password_txt.text;
//     String _confirmpassword = widget.confirmpassword_txt.text;
//     String _url = 'http://192.168.1.41:8000/api/test_post/';
//     print(_username);
//     print(_password);
//     var param_map = {
//       'email': _email,
//       'username': _username,
//       'password': _password,
//       'confirmpassword': _confirmpassword
//     };
//     print(param_map);
//     var jsontxt = json.encode(param_map);
//     var response = await http.post(
//       Uri.parse(_url),
//       body: jsontxt,
//       headers: {'Content-Type': "application/json"},
//     );
//     var result_map = json.decode(response.body);
//     print(result_map);
//     if (result_map['status_code'] == 200) {
//       Navigator.pushNamed(context, CompleteProfileScreen.routeName);
//     } //end of if
//     else if (result_map['status_code'] != 200) {
//       var message = result_map['message'];
//       _showDialog2(context, message);
//     }
//   }

//   void _showDialog2(BuildContext context, String return_message) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: new Text("Alert !!"),
//           content: new Text(return_message),
//           actions: <Widget>[
//             TextButton(
//               child: new Text("OK"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   } //end of show dialog function

// }//ef
