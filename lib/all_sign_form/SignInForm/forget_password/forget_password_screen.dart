import 'package:blocktrade/all_sign_form/components/custom_surfix_icon.dart';
import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/components/form_error.dart';
import 'package:blocktrade/all_sign_form/components/no_account_text.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/constants.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/forget_password";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text("Forget Password"),
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
      child: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight! * 0.04),
              Text(
                "Forget Password",
                style: TextStyle(
                  fontSize: getProportionateScreenWidth(28),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Please enter your email and we will send \nyou a link to return to your account",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.1),
              ForgetPassForm(),
            ],
          ),
        ),
      ),
    );
  }
} //ef

class ForgetPassForm extends StatefulWidget {
  @override
  _ForgetPassFormState createState() => _ForgetPassFormState();
}

class _ForgetPassFormState extends State<ForgetPassForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  //late String email;
  late String username;
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
          TextFormField(
            onSaved: (newValue) => username = newValue!,
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
          ),
          // TextFormField(
          //   onSaved: (newValue) => email = newValue!,
          //   keyboardType: TextInputType.emailAddress,
          //   onChanged: (value) {
          //     if (value.isNotEmpty) {
          //       removeError(error: kEmailNullError);
          //     } else if (emailValidatorRegExp.hasMatch(value)) {
          //       removeError(error: kInvalidEmailError);
          //     }
          //     return null;
          //   },
          //   validator: (value) {
          //     if (value!.isEmpty) {
          //       addError(error: kEmailNullError);
          //     } else if (!emailValidatorRegExp.hasMatch(value)) {
          //       addError(error: kInvalidEmailError);
          //     }
          //     return null;
          //   },
          //   //style: TextStyle(fontSize: 20),
          //   decoration: InputDecoration(
          //     labelText: "Email",
          //     hintText: "Enter your email",
          //     //If you are using latest version of flutter then
          //     //lable textand hint text and text shown like this
          //     // if you r using flutter less than 1.20.* then maybe this is not working properly
          //     floatingLabelBehavior: FloatingLabelBehavior.always,
          //     suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
          //   ),
          // ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: SizeConfig.screenHeight! * 0.1),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                //Do what you wanna do
              }
            },
          ),
          SizedBox(height: SizeConfig.screenHeight! * 0.1),
          NoAccountText(),
        ],
      ),
    );
  }
}//ef