import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/main.dart';
import 'package:flutter/material.dart';

class SignUpSuccessScreen extends StatelessWidget {
  static String routeName = "/signup_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text("Sign Up Success"),
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
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.05),
        SizedBox(
          child: Image.asset(
            "assets/images/success.png",
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Sign Up Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          //height: SizeConfig.screenWidth! * 0.2,
          child: DefaultButton(
            text: "Let's go to Shopping! ",
            //press: () {},
            // press: () => Navigator.pushNamed(context, HomeScreen.routeName),
            // press: () => Navigator.pushNamed(context, HomePage.routeName),
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return HomePage();
                  },
                ),
              );
            },
          ),
        ),
        Spacer(),
      ],
    );
  }
}//ef
