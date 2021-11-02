import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/main.dart';
import 'package:flutter/material.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text("Log In Success"),
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
            "assets/images/trade_splash2.png",
            // "assets/images/success_check3.png",
            // color: // Color(0xFF868F74),
            //     // Color(0xFFDED7C4),
            //     Colors.black,
            height: SizeConfig.screenHeight! * 0.5,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            text: "Go to home",
            //press: () {},
            // press: () => Navigator.pushNamed(context, HomeScreen.routeName),
            //press: () => Navigator.pushNamed(context, HomePage.routeName),
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
