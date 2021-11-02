import 'package:blocktrade/all_sign_form/size_config.dart';
import 'package:blocktrade/all_sign_form/splash/splash_screen.dart';
import 'package:blocktrade/store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

final f1 = NumberFormat("#,##0.", "en_US");
final f2 = NumberFormat("#,##0.00", "en_US");

class Drawerpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * .6,

        // decoration: BoxDecoration(
        //     color: Colors.white,
        //     borderRadius: BorderRadius.all(Radius.circular(15)),
        //     boxShadow: [
        //       BoxShadow(
        //           color: Colors.black54.withOpacity(0.2),
        //           offset: Offset(0, 0),
        //           blurRadius: 15)
        //     ]),
        child: Drawer(
          child: Column(
            //ListView(
            children: [
              // SizedBox(height: 10),
              SizedBox(height: SizeConfig.screenHeight! * 0.01),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getProportionateScreenWidth(1)),
                    padding: EdgeInsetsDirectional.all(
                        getProportionateScreenWidth(5)),
                    // margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    //   border: Border.all(width: 0.4),
                    // ),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Text(
                            "More",
                            style: TextStyle(
                                fontSize: 30,
                                color:
                                    // Colors.grey.shade500,
                                    // Color(0xFF8496A2),
                                    Color(0xFF687A86),
                                fontWeight: FontWeight.bold),
                          ),
                          //profile
                          Container(
                            // decoration: BoxDecoration(
                            //   borderRadius:
                            //       BorderRadius.all(Radius.circular(10)),
                            //   border: Border.all(width: 0.4),
                            // ),
                            //margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: ProfileRnd(
                              heightcam: 46,
                              widthcam: 46,
                              widthprofile: 200,
                              heightprofile: 200,
                              positioncamRight: 20,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              print("Button Got Called");
                            },
                            child: Text("Check Port"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
              SizedBox(height: SizeConfig.screenHeight! * 0.005),
              Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(10)),
                //   border: Border.all(width: 0.4),
                // ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                width: 230,
                height: 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Mr. Steve Krug",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // SizedBox(height: 10),
                    SizedBox(height: SizeConfig.screenHeight! * 0.005),
                    //Email
                    Text(
                      "Email:",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Steve_Kr@gmail.com",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Phone number:",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Phone number
                    SizedBox(height: 5),
                    Text(
                      "089-999-9999",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              SizedBox(height: SizeConfig.screenHeight! * 0.005),
              // Expanded(
              //   flex: 2,
              //   child:
              // ),
              Column(
                children: [
                  Container(
                    width: 250,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: CreditBoxDecoration(),
                    child: CreditBox(sizeofCreditNumber: 30),
                  ),
                ],
              ),
              //Expanded(flex: 2, child: SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

BoxDecoration CreditBoxDecoration() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    border: Border.all(width: 0.4, color: Colors.white),
    color:
        //  Color(0xFFD3A784)
        // Color(0xFF8496A2),
        Color(0xFF687A86),
  );
}

class ProfileRnd extends StatelessWidget {
  final double heightprofile;
  final double widthprofile;
  final double heightcam;
  final double widthcam;
  final double positioncamRight;
  const ProfileRnd({
    Key? key,
    required this.heightprofile,
    required this.widthprofile,
    required this.heightcam,
    required this.widthcam,
    required this.positioncamRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heightprofile,
      width: widthprofile,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
            backgroundColor: Colors.white,
          ),
          Positioned(
            right: positioncamRight,
            bottom: 0,
            child: SizedBox(
              height: heightcam,
              width: widthcam,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.grey.shade200,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                onPressed: () {},
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CreditBox extends StatefulWidget {
  final double sizeofCreditNumber;
  const CreditBox({
    Key? key,
    required this.sizeofCreditNumber,
  }) : super(key: key);

  @override
  _CreditBoxState createState() => _CreditBoxState();
}

class _CreditBoxState extends State<CreditBox> {
  @override
  Widget build(BuildContext context) {
    Store store1 = Provider.of<Store>(context);
    if (store1.balance_status == true) {
      if (store1.cash_balance == 'notfound') {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Line Available:",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Account not found",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.sizeofCreditNumber),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "last updated at 5 p.m.",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    IconButton(
                      onPressed: () {
                        print('refresh');
                      },
                      icon: Icon(Icons.restart_alt),
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ],
        );
      }
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Line Available:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            f2
                                .format(
                                  double.parse(
                                    store1.cash_balance,
                                  ),
                                )
                                .toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: widget.sizeofCreditNumber),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "last updated at 5 p.m.",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  IconButton(
                    onPressed: () {
                      print('refresh');
                    },
                    icon: Icon(Icons.restart_alt),
                    color: Colors.white,
                  ),
                ],
              )
            ],
          ),
        ],
      );
    } //end of if
    else {
      store1.checkBalance();
      return Center(
        child: CircularProgressIndicator(),
      );
    } //end of else
  } //end of build function
} //ec

// Expanded(
// flex: 3,
// child:
// Column(
// mainAxisAlignment: MainAxisAlignment.end,
// children: [
// // Text("text"),
// menu(context, 0, "tab1", Icons.home),
// menu(context, 1, "tab2", Icons.notifications),
// menu(context, 2, "tab3", Icons.shop),
// menu(context, 3, "tab4", Icons.send),
// ],
// ),
// ),

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.context,
    //required this.index,
    required this.text,
    required this.iconData,
  }) : super(key: key);

  final BuildContext context;
  //final int index;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    //var store1 = Provider.of<Store>(context);
    return ListTile(
      //make different color
      // trailing: Icon(iconData,
      //     color: store1.activeTab == index
      //         ? Colors.green.shade300
      //         : Colors.grey.shade700),
      trailing: Icon(iconData,
          color:
              // Colors.green.shade300
              Colors.grey.shade700),
      title: Text(
        text,
        style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 19,
            fontWeight: FontWeight.bold),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              // return SignInScreen();
              // return LoginSuccessScreen();
              return SplashScreen();
            },
          ),
        );

        // store1.setActiveTab(index);
        // Navigator.pop(context); //pop to stop the tab
      },
    );
  }
} //ec
