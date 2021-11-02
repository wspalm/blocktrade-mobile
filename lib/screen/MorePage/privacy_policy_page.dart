import 'package:blocktrade/store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var store1 = Provider.of<Store>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 26),
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "USE OF YOUR INFORMATION ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" Having accurate information about you" +
                      " permits us to provide you with a smooth, efficient, and" +
                      "customized experience.  "),
                  SizedBox(height: 10),
                  Text(
                    "By Law or to Protect Rights",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("If we believe the release of information about you is " +
                      " necessary to respond to legal process, to investigate or remedy " +
                      "potential violations of our policies, or to protect the rights, property, and " +
                      "safety of others, we may share your information as permitted or required by any " +
                      "applicable law, rule, or regulation. This includes exchanging information with" +
                      " other entities for fraud protection and credit risk reduction."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container NL() => Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Divider(
          color: Colors.grey,
        ),
      );
}
