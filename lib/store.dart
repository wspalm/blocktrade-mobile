import 'dart:convert';
import 'dart:convert';
import 'package:blocktrade/screen/order_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

const key1 = "ah@KDIs3d7fsKTk@sefsrxpSJccqidQr029@238Fsdf@sdfYY@w2f0wef0wef";

class Store extends ChangeNotifier {
//data
  int _activeTab = 0;
//getter
  int get activeTab => _activeTab;
//setter
  void setActiveTab(int index) {
    _activeTab = index;
    notifyListeners();
  } //ef

  bool _status = false;
  bool get status => _status;

  //For Language Settings
  String _h1 = "home";
  String _h2 = "about";
  String _h3 = "settings";
  String _h4 = "language settings";
  String _h5 = "orderhistory";
  String _h6 = "buy";
  String _h7 = "stocksymbol";
  String _h8 = "volume";
  String _h9 = "pin";
  String get h1 => _h1;
  String get h2 => _h2;
  String get h3 => _h3;
  String get h4 => _h4;
  String get h5 => _h5;
  String get h6 => _h6;
  String get h7 => _h7;
  String get h8 => _h8;
  String get h9 => _h9;

  //showAverage
  bool _showAverage = false;
  bool get showAverage => _showAverage;
  void toggleShowAverage() {
    _showAverage = !_showAverage;
    notifyListeners();
  }

  String _customerUsername = '';
  String get customerUsername => _customerUsername;

  void setValue(String loginString) {
    _customerUsername = loginString;
    notifyListeners();
  } //end of function setValue

  List<OrderHistory> orderHistoryList = [];

  Future<List<OrderHistory>> list_order() async {
    const _url = 'http://192.168.1.41:8000/api/orderhistory/';

    var param = {'username': customerUsername};

    var jsontxt = json.encode(param);
    var response = await http.post(
      Uri.parse(_url),
      body: jsontxt,
      headers: {'Content-Type': "application/json"},
    );
    _status = true;
    var result_map = await json.decode(response.body) as List;
    return result_map.map((e) => OrderHistory.fromMap(e)).toList();
  } //end of list_order function

  String _cash_balance = '';
  String get cash_balance => _cash_balance;

  bool _balance_status = false;
  bool get balance_status => _balance_status;

  bool _act_status = true;
  bool get act_status => _act_status;

  void bStatSet() {
    _balance_status = true;
    notifyListeners();
  } //end of balance status setter function

  void actStatSet() {
    _act_status = false;
    notifyListeners();
  }

  checkBalance() async {
    var param = {
      'application_key': key1.toString(),
      'param1': customerUsername
    };
    var jsontxt = json.encode(param);
    var _url = "http://192.168.1.41:8000/api/user_data/";
    var response = await http.post(
      Uri.parse(_url),
      body: jsontxt,
      headers: {'Content-Type': "application/json"},
    );
    var result = await json.decode(response.body);
    _cash_balance = result['message'];
    if (_cash_balance == 'notfound') {
      actStatSet();
    } //end of if
    bStatSet();
  } //end of function checkBalance

  void logout() {
    print("Function logout got called ++++++++++++++++++++++++++++++++++++++");
    //_activeTab = 0;
    _status = false;
    _customerUsername = '';
    orderHistoryList = [];
    _cash_balance = '';
    _balance_status = false;
    _act_status = true;
    //print("This is status -->> ");
    //print(_status);
    //print("This is _customerUsername ---->> ");
    //print(_customerUsername);
    //print("This is orderHistoryList ---->> ");
    //print(orderHistoryList);
    //print("This is _cash_balance ---->> ");
    //print(_cash_balance);
    //print("This is _act_status ---->> ");
    //print(_act_status);
    notifyListeners();
  } //end of function logout

} //ec

// void main() async {
//   //setup your app to your use flutter engine
//   //so that it can support easylocalization
//   WidgetsFlutterBinding.ensureInitialized();
//   await EasyLocalization.ensureInitialized();
//   //return the runnable application
//   return runApp(
//     EasyLocalization(
//       //it's so important
//       //we have to spacific path of .json clearly
//       path: 'assets/languages',
//       //what is the default language
//       //fallbackLocale: Locale('en', 'US'),
//       fallbackLocale: Locale('th', 'TH'),
//       supportedLocales: [
//         //us eng
//         Locale('en', 'US'),
//         //thai
//         Locale('th', "TH"),
//         //chinese
//         Locale('zh', "CN"),
//       ],
//       child: ChangeNotifierProvider(
//         //register function
//         create: (context) => new Store(),
//         //hold your app
//         child: App(),
//       ),
//     ),
//   );
//   // runApp(MyApp());
// } //ec

// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       //remove debug tag
//       debugShowCheckedModeBanner: false,
//       //include the easylocaization support here
//       localizationsDelegates: context.localizationDelegates,
//       supportedLocales: context.supportedLocales,
//       locale: context.locale,
//       theme: theme(),
//       // home: HomePage(),
//       // //home: SplashScreen(),
//       initialRoute: SplashScreen.routeName,
//       //initialRoute: ProfileScreen.routeName,
//       routes: routes,
//     );
//   } //e
// } //ec
