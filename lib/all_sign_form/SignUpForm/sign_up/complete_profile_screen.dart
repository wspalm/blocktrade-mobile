import 'package:blocktrade/all_sign_form/SignUpForm/otp/otp_screen.dart';
import 'package:blocktrade/all_sign_form/components/custom_surfix_icon.dart';
import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/components/form_error.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/constants.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blocktrade/all_sign_form/SignInForm/sign_in/sign_in_screen.dart';
import './signup.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_profile";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
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
              SizedBox(height: SizeConfig.screenHeight! * 0.05), //5%
              Text(
                "Complete Profile",
                style: headingStyle,
              ),
              Text(
                "Complete your details or continue \nwith social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.05), //5%
              CompleteProfileForm(),
              SizedBox(height: getProportionateScreenHeight(30)),
              Text(
                "By Continuing your confirm that you agree \nwith our Term and Condition",
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
} //ef

class CompleteProfileForm extends StatefulWidget {
  TextEditingController firstname_txt = new TextEditingController();
  TextEditingController lastname_txt = new TextEditingController();
  TextEditingController phonenumber_txt = new TextEditingController();
  TextEditingController act_no = new TextEditingController();
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String accountNo;
  //late String address;
  //late String username;

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
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildActFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneNumberFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          //buildAddressFormField(),
          //buildUsernameFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Sign-Up",
            press: () {
              if (_formKey.currentState!.validate()) {
                //Go to OTP screen
                // Navigator.pushNamed(context, OtpScreen.routename);
                get_ready2(context);
              }
            },
          )
        ],
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: widget.firstname_txt,
      onSaved: (newValue) => firstName = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  } //ec

  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!,
      controller: widget.lastname_txt,
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildActFormField() {
    return TextFormField(
      onSaved: (newValue) => accountNo = newValue!,
      controller: widget.act_no,
      // const String kActNoNullError = "Please Enter your Account No.";
      // const String kInvalidActNoError = "Please Enter Valid Account No.";
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kActNoNullError);
        } else if (actNoValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidActNoError);
        }
        accountNo = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kActNoNullError);
          return "";
        } else if (!actNoValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidActNoError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Account No",
        hintText: "Enter your Account No",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      controller: widget.phonenumber_txt,
      onSaved: (newValue) => phoneNumber = newValue!,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  void get_ready2(BuildContext context) {
    String _firstname = widget.firstname_txt.text;
    String _lastname = widget.lastname_txt.text;
    String _act_no = widget.act_no.text;
    String _mobile = widget.phonenumber_txt.text;

    sending_obj['first_name'] = _firstname;
    sending_obj['last_name'] = _lastname;
    sending_obj['act_no'] = _act_no;
    sending_obj['mobile'] = _mobile;

    signUp();
  } //end of get_ready2

  _showDialog2(BuildContext context, String return_message) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Notification"),
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

  _showDialog3(BuildContext context, String return_message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Notification"),
          content: new Text(return_message),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  } //end of show dialog function

  void signUp() async {
    String _url = 'http://192.168.1.41:8000/api/test_signup/';

    var jsontxt = json.encode(sending_obj);
    var response = await http.post(
      Uri.parse(_url),
      body: jsontxt,
      headers: {'Content-Type': "application/json"},
    );
    var result_map = json.decode(response.body);
    print(result_map);
    if (result_map['status_code'] == 200) {
      //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
      var message = result_map['message'];
      print(message);
      _showDialog3(context, message); // a1

      //to do -- navigate to success signup page
      //remove a1
      //and in that page , show some message saying that
      //signup success and wait for admin approval

    } //end of if
    else if (result_map['status_code'] != 200) {
      var message = result_map['message'];
      print(message);
      _showDialog2(context, message);
    } //end of else if
  } //end of function

} //ef

/*
myusername
mypassword
mypassword

myfirstname
mylastname

111111-1
0811111111
*/

// class CompleteProfileScreen extends StatelessWidget {
//   static String routeName = "/complete_profile";
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Sign Up"),
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
//               SizedBox(height: SizeConfig.screenHeight! * 0.05), //5%
//               Text(
//                 "Complete Profile",
//                 style: headingStyle,
//               ),
//               Text(
//                 "Complete your details or continue \nwith social media",
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: SizeConfig.screenHeight! * 0.05), //5%
//               CompleteProfileForm(),
//               SizedBox(height: getProportionateScreenHeight(30)),
//               Text(
//                 "By Continuing your confirm that you agree \nwith our Term and Condition",
//                 textAlign: TextAlign.center,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// } //ef

// class CompleteProfileForm extends StatefulWidget {
//   TextEditingController firstname_txt = new TextEditingController();
//   TextEditingController lastname_txt = new TextEditingController();
//   TextEditingController phonenumber_txt = new TextEditingController();
//   @override
//   _CompleteProfileFormState createState() => _CompleteProfileFormState();
// }

// class _CompleteProfileFormState extends State<CompleteProfileForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> errors = [];
//   late String firstName;
//   late String lastName;
//   late String phoneNumber;
//   //late String address;
//   //late String username;

//   void addError({required String error}) {
//     if (!errors.contains(error))
//       setState(() {
//         errors.add(error);
//       });
//   } //ef

//   void removeError({required String error}) {
//     if (errors.contains(error))
//       setState(() {
//         errors.remove(error);
//       });
//   } //ef

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildFirstNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildLastNameFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPhoneNumberFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           //buildAddressFormField(),
//           //buildUsernameFormField(),
//           FormError(errors: errors),
//           SizedBox(height: getProportionateScreenHeight(40)),
//           DefaultButton(
//             text: "Continue",
//             press: () {
//               if (_formKey.currentState!.validate()) {
//                 //Go to OTP screen
//                 // Navigator.pushNamed(context, OtpScreen.routename);
//                 completeSignUp(context);
//               }
//             },
//           )
//         ],
//       ),
//     );
//   }

//   TextFormField buildFirstNameFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       controller: widget.firstname_txt,
//       onSaved: (newValue) => firstName = newValue!,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kNameNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kEmailNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "First Name",
//         hintText: "Enter your first name",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   } //ec

//   TextFormField buildLastNameFormField() {
//     return TextFormField(
//       onSaved: (newValue) => lastName = newValue!,
//       controller: widget.lastname_txt,
//       decoration: InputDecoration(
//         labelText: "Last Name",
//         hintText: "Enter your last name",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
//       ),
//     );
//   }

//   TextFormField buildPhoneNumberFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       controller: widget.phonenumber_txt,
//       onSaved: (newValue) => phoneNumber = newValue!,
//       onChanged: (value) {
//         if (value.isNotEmpty) {
//           removeError(error: kPhoneNumberNullError);
//         }
//         return null;
//       },
//       validator: (value) {
//         if (value!.isEmpty) {
//           addError(error: kPhoneNumberNullError);
//           return "";
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Phone Number",
//         hintText: "Enter your phone number",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
//       ),
//     );
//   }

//   void completeSignUp(BuildContext context) async {
//     String _firstname = widget.firstname_txt.text;
//     String _lastname = widget.lastname_txt.text;
//     String _phonenumber = widget.phonenumber_txt.text;
//     String _url = 'http://192.168.1.41:8000/api/test_post/';
//     print(_firstname);
//     print(_lastname);
//     print(_phonenumber);
//     var param_map = {
//       'firstname': _firstname,
//       'lastname': _lastname,
//       'phonenumber': _phonenumber
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
//       Navigator.pushNamed(context, OtpScreen.routename);
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