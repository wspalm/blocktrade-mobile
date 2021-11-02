import 'package:blocktrade/all_sign_form/components/default_button.dart';
import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/constants.dart';
import 'package:blocktrade/main.dart';
import 'package:blocktrade/screen/portfolio_page.dart';
import 'package:blocktrade/store.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../drawer_page.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

//field variable
TextEditingController serieSymbol = new TextEditingController();
TextEditingController blockAmount = new TextEditingController();

//Order Execution Page
class Tab3 extends StatefulWidget {
  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  @override
  Widget build(BuildContext context) {
    Store store1 = Provider.of<Store>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10),
            SizedBox(height: SizeConfig.screenHeight! * 0.01),
            creditPart(),

            // SizedBox(height: SizeConfig.screenHeight! * 0.005),
            // SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black54.withOpacity(0.2),
                        offset: Offset(0, 0),
                        blurRadius: 15)
                  ]),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.03),
            // SizedBox(height: 20),
            OrderForm(),
            SizedBox(height: SizeConfig.screenHeight! * 0.03),
            // SizedBox(height: 50),
            GestureDetector(
              // onTap: () => print("BUY"),
              onTap: () async {
                if (!store1.act_status) {
                  _showDialog3(context);
                  return;
                } //end of if
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Your Order Is Sending . . .'),
                    duration: Duration(milliseconds: 800),
                  ),
                );
                print("Data in the store --->>> ");
                print(store1.customerUsername);
                String _url = 'http://192.168.1.41:8000/api/placeorder/';

                var param_map = {
                  'symbol': serieSymbol.text,
                  'block_amount': blockAmount.text,
                  'user_info': store1.customerUsername,
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
                  Navigator.pushNamed(context, OrderSuccessScreen.routeName);
                  serieSymbol.text = '';
                  blockAmount.text = '';
                } //end of if
                else if (result_map['status_code'] != 200) {
                  var message = result_map['message'];
                  _showDialog2(context, message);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color(0xFF687A86),
                ),
                width: MediaQuery.of(context).size.width - 200,
                height: 60,
                child: Center(
                  child: Text(
                    // "Buy",
                    store1.h6.tr(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.03),
          ],
        ),
      ),
    );
  } //end of build functon

  TextFormField buildStockFormField() {
    var store1 = Provider.of<Store>(context);
    return TextFormField(
      decoration: InputDecoration(
        // labelText: "Stock symbol",
        labelText: store1.h7.tr(),
        hintText: "Enter symbol",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade600),
            gapPadding: 10),
      ),
    );
  } //end of symbol widget

  TextFormField buildVolumeFormField() {
    var store1 = Provider.of<Store>(context);
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // labelText: "Volume",
        labelText: store1.h8.tr(),
        hintText: "Ente volume",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade600),
            gapPadding: 10),
      ),
    );
  } //end of volume widget

} //end of class

void _showDialog(BuildContext context, String return_message) {
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
              Navigator.pushNamed(context, OrderSuccessScreen.routeName);
            },
          ),
        ],
      );
    },
  );
} //end of show dialog function

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

void _showDialog3(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Notification"),
        content: new Text(
            "You don't have account with us yet , please contact us to open account"),
        actions: <Widget>[
          TextButton(
            child: new Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
              serieSymbol.text = '';
              blockAmount.text = '';
              Navigator.pushNamed(context, HomePage.routeName);
            },
          ),
        ],
      );
    },
  );
} //end of show dialog function

class OrderForm extends StatefulWidget {
  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  late String stock;
  late String price;
  late String volume;
  late String pin;
  //bool remember = false;

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
    var store1 = Provider.of<Store>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            buildStockFormField(),
            SizedBox(height: SizeConfig.screenHeight! * 0.025),
            // SizedBox(height: 25),
            // buildPriceFormField(),
            // SizedBox(height: SizeConfig.screenHeight! * 0.025),
            // SizedBox(height: 25),
            buildVolumeFormField(),
            SizedBox(height: SizeConfig.screenHeight! * 0.025),
            // SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  TextFormField buildStockFormField() {
    var store1 = Provider.of<Store>(context);
    return TextFormField(
      controller: serieSymbol,
      decoration: InputDecoration(
        // labelText: "Stock symbol",
        labelText: store1.h7.tr(),
        hintText: "Enter symbol",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade600),
            gapPadding: 10),
      ),
    );
  }

  TextFormField buildPriceFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      //onSaved: (newValue) => price = newValue!,

      decoration: InputDecoration(
        labelText: "Price",
        hintText: "Enter price",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade600),
            gapPadding: 10),
      ),
    );
  }

  TextFormField buildVolumeFormField() {
    var store1 = Provider.of<Store>(context);
    return TextFormField(
      controller: blockAmount,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // labelText: "Volume",
        labelText: store1.h8.tr(),
        hintText: "Ente volume",
        contentPadding: EdgeInsets.symmetric(
          horizontal: 42,
          vertical: 15,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade400),
            gapPadding: 10),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey.shade600),
            gapPadding: 10),
      ),
    );
  }

  //TextFormField buildpinFormField() {
  //  var store1 = Provider.of<Store>(context);
  //  return TextFormField(
  //    obscureText: true,
  //    //onSaved: (newValue) => pin = newValue!,
  //    // onChanged: (value) {
  //    //   if (value.isNotEmpty) {
  //    //     removeError(error: kPinNullError);
  //    //   }
  //    //   return null;
  //    // },
  //    // validator: (value) {
  //    //   if (value!.isEmpty) {
  //    //     addError(error: kPinNullError);
  //    //     return "";
  //    //   }
  //    //   return null;
  //    // },
  //    keyboardType: TextInputType.emailAddress,
  //    decoration: InputDecoration(
  //      // labelText: "Pin",
  //      labelText: store1.h9.tr(),
  //      hintText: "Enter your pin",
  //      contentPadding: EdgeInsets.symmetric(
  //        horizontal: 42,
  //        vertical: 15,
  //      ),
  //      floatingLabelBehavior: FloatingLabelBehavior.always,
  //      suffixIcon: Icon(Icons.lock),
  //      enabledBorder: OutlineInputBorder(
  //          borderRadius: BorderRadius.circular(25),
  //          borderSide: BorderSide(color: Colors.grey.shade400),
  //          gapPadding: 10),
  //      focusedBorder: OutlineInputBorder(
  //          borderRadius: BorderRadius.circular(25),
  //          borderSide: BorderSide(color: Colors.grey.shade600),
  //          gapPadding: 10),
  //    ),
  //  );
  //}

}

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key? key,
    required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: SvgPicture.asset(
        svgIcon,
        height: 10,
      ),
    );
  }
} //ef

// ignore: camel_case_types
class creditPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,

      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(left: 30, right: 30),
      decoration: CreditBoxDecoration(),
      child: CreditBox(sizeofCreditNumber: 45),
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   children: [
      //     Column(
      //       children: [
      //         Row(
      //           children: [
      //             Container(
      //               margin: EdgeInsets.only(left: 25),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   SizedBox(height: 10),
      //                   Text(
      //                     "Credit:",
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 20,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                   SizedBox(height: 6),
      //                   Text(
      //                     "\$ 3,000,000",
      //                     style: TextStyle(
      //                         color: Colors.white,
      //                         fontSize: 45,
      //                         fontWeight: FontWeight.bold),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //         SizedBox(height: 6),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             Text(
      //               "last updated at 5 p.m.",
      //               style: TextStyle(color: Colors.white, fontSize: 17),
      //             ),
      //             Icon(
      //               Icons.restart_alt,
      //               color: Colors.white,
      //             ),
      //           ],
      //         )
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
} //ec

class OrderSuccessScreen extends StatelessWidget {
  static String routeName = "/order_success";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 80),
          child: Text("Order Success"),
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
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.04),
        Text(
          "Order Success",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(35),
            fontWeight: FontWeight.bold,
            color: kPrimaryColor,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight! * 0.01),
        Text(
          "Wait for Marketing Approval",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(13),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          //height: SizeConfig.screenWidth! * 0.2,
          child: DefaultButton(
            text: "Back to Home",
            //press: () {},
            // press: () => Navigator.pushNamed(context, Tab1.routeName),
            press: () => Navigator.pushNamed(context, HomePage.routeName),
            // press: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute<void>(
            //       builder: (BuildContext context) {
            //         return HomePage();
            //       },
            //     ),
            //   );
            // },
          ),
        ),
        Spacer(),
      ],
    );
  }
} //ef

// //Order Execution Page
// class Tab3 extends StatefulWidget {
//   @override
//   _Tab3State createState() => _Tab3State();
// }
// class _Tab3State extends State<Tab3> {
//   @override
//   Widget build(BuildContext context) {
//     var store1 = Provider.of<Store>(context);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // SizedBox(height: 10),
//             SizedBox(height: SizeConfig.screenHeight! * 0.01),
//             creditPart(),
//             // SizedBox(height: SizeConfig.screenHeight! * 0.005),
//             // SizedBox(height: 10),
//             Container(
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.all(Radius.circular(15)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black54.withOpacity(0.2),
//                         offset: Offset(0, 0),
//                         blurRadius: 15)
//                   ]),
//             ),
//             SizedBox(height: SizeConfig.screenHeight! * 0.03),
//             // SizedBox(height: 20),
//             OrderForm(),
//             SizedBox(height: SizeConfig.screenHeight! * 0.03),
//             // SizedBox(height: 50),
//             GestureDetector(
//               // onTap: () => print("BUY"),
//               onTap: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text('Your Order Is Sending . . .'),
//                     duration: Duration(milliseconds: 800),
//                   ),
//                 );
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute<void>(
//                 //     builder: (BuildContext context) {
//                 //       //return SignInScreen();
//                 //       //return LoginSuccessScreen();
//                 //     },
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   color:
//                       // Color(0xFFA3CB8F),
//                       // Color(0xFF8496A2),
//                       Color(0xFF687A86),
//                 ),
//                 width: MediaQuery.of(context).size.width - 200,
//                 height: 60,
//                 child: Center(
//                   child: Text(
//                     // "Buy",
//                     store1.h6.tr(),
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: SizeConfig.screenHeight! * 0.03),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class OrderForm extends StatefulWidget {
//   @override
//   _OrderFormState createState() => _OrderFormState();
// }
// class _OrderFormState extends State<OrderForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> errors = [];
//   late String stock;
//   late String price;
//   late String volume;
//   late String pin;
//   //bool remember = false;
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
//     var store1 = Provider.of<Store>(context);
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 40),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             buildStockFormField(),
//             SizedBox(height: SizeConfig.screenHeight! * 0.025),
//             // SizedBox(height: 25),
//             // buildPriceFormField(),
//             // SizedBox(height: SizeConfig.screenHeight! * 0.025),
//             // SizedBox(height: 25),
//             buildVolumeFormField(),
//             SizedBox(height: SizeConfig.screenHeight! * 0.025),
//             // SizedBox(height: 25),
//             buildpinFormField(),
//           ],
//         ),
//       ),
//     );
//   }
//   TextFormField buildStockFormField() {
//     var store1 = Provider.of<Store>(context);
//     return TextFormField(
//       decoration: InputDecoration(
//         // labelText: "Stock symbol",
//         labelText: store1.h7.tr(),
//         hintText: "Enter stock symbol",
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 42,
//           vertical: 15,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade400),
//             gapPadding: 10),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade600),
//             gapPadding: 10),
//       ),
//     );
//   }
//   TextFormField buildPriceFormField() {
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       //onSaved: (newValue) => price = newValue!,
//       decoration: InputDecoration(
//         labelText: "Price",
//         hintText: "Enter price",
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 42,
//           vertical: 15,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade400),
//             gapPadding: 10),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade600),
//             gapPadding: 10),
//       ),
//     );
//   }
//   TextFormField buildVolumeFormField() {
//     var store1 = Provider.of<Store>(context);
//     return TextFormField(
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         // labelText: "Volume",
//         labelText: store1.h8.tr(),
//         hintText: "Ente volume",
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 42,
//           vertical: 15,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade400),
//             gapPadding: 10),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade600),
//             gapPadding: 10),
//       ),
//     );
//   }
//   TextFormField buildpinFormField() {
//     var store1 = Provider.of<Store>(context);
//     return TextFormField(
//       obscureText: true,
//       //onSaved: (newValue) => pin = newValue!,
//       // onChanged: (value) {
//       //   if (value.isNotEmpty) {
//       //     removeError(error: kPinNullError);
//       //   }
//       //   return null;
//       // },
//       // validator: (value) {
//       //   if (value!.isEmpty) {
//       //     addError(error: kPinNullError);
//       //     return "";
//       //   }
//       //   return null;
//       // },
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         // labelText: "Pin",
//         labelText: store1.h9.tr(),
//         hintText: "Enter your pin",
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 42,
//           vertical: 15,
//         ),
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: Icon(Icons.lock),
//         enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade400),
//             gapPadding: 10),
//         focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25),
//             borderSide: BorderSide(color: Colors.grey.shade600),
//             gapPadding: 10),
//       ),
//     );
//   }
// }
// class CustomSurffixIcon extends StatelessWidget {
//   const CustomSurffixIcon({
//     Key? key,
//     required this.svgIcon,
//   }) : super(key: key);
//   final String svgIcon;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(3),
//       child: SvgPicture.asset(
//         svgIcon,
//         height: 10,
//       ),
//     );
//   }
// } //ef
// // ignore: camel_case_types
// class creditPart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(5),
//       margin: EdgeInsets.only(left: 30, right: 30),
//       decoration: CreditBoxDecoration(),
//       child: CreditBox(sizeofCreditNumber: 45),
//       // child: Column(
//       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //   children: [
//       //     Column(
//       //       children: [
//       //         Row(
//       //           children: [
//       //             Container(
//       //               margin: EdgeInsets.only(left: 25),
//       //               child: Column(
//       //                 crossAxisAlignment: CrossAxisAlignment.start,
//       //                 children: [
//       //                   SizedBox(height: 10),
//       //                   Text(
//       //                     "Credit:",
//       //                     style: TextStyle(
//       //                         color: Colors.white,
//       //                         fontSize: 20,
//       //                         fontWeight: FontWeight.bold),
//       //                   ),
//       //                   SizedBox(height: 6),
//       //                   Text(
//       //                     "\$ 3,000,000",
//       //                     style: TextStyle(
//       //                         color: Colors.white,
//       //                         fontSize: 45,
//       //                         fontWeight: FontWeight.bold),
//       //                   ),
//       //                 ],
//       //               ),
//       //             ),
//       //           ],
//       //         ),
//       //         SizedBox(height: 6),
//       //         Row(
//       //           mainAxisAlignment: MainAxisAlignment.end,
//       //           children: [
//       //             Text(
//       //               "last updated at 5 p.m.",
//       //               style: TextStyle(color: Colors.white, fontSize: 17),
//       //             ),
//       //             Icon(
//       //               Icons.restart_alt,
//       //               color: Colors.white,
//       //             ),
//       //           ],
//       //         )
//       //       ],
//       //     ),
//       //   ],
//       // ),
//     );
//   }
// } //ec
