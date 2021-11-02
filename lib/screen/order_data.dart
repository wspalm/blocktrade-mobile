import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../store.dart';
import 'order_class.dart';

get_orderhistory(BuildContext context) async {
  print("The function got called");

  const _url = 'http://192.168.1.41:8000/api/orderhistory/';

  Store store1 = Provider.of<Store>(context);
  String _username = store1.customerUsername;

  var param = {'username': _username};
  print("This is parameter ---->>> ");
  var jsontxt = json.encode(param);
  var response = await http.post(
    Uri.parse(_url),
    body: jsontxt,
    headers: {'Content-Type': "application/json"},
  );
  var result_map = json.decode(response.body) as List;
  print("This is result mapped --->> ");
  return result_map;
}//end of get orderhistory function

