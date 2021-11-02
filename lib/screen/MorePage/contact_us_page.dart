import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var store1 = Provider.of<Store>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Us',
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
                'Contact Us',
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
                    "GLOBLEX SECURITIES CO., LTD. (Head Office) ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(" 87/2 CRC Tower, All Seasons Place, " +
                      "  12th Floor, Wireless Road, Lumpini, " +
                      " Pathumwan, Bangkok 10330 "),
                  Text("  Tel : 0-2672-5999, 0-2687-7000 "),
                  Text("  Fax : 0-2672-5888 "),
                  SizedBox(height: 20),
                  Text(
                    "GLOBLEX SECURITIES CO., LTD. (Chiang Mai Branch)",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("2 Central Airport Plaza, 1st Floor, " +
                      "  Mahidol Road, Amphoe Muang,  " +
                      "Chiang Mai 50100 "),
                  Text(" Tel : 053-903-599 "),
                  Text("  Fax : 053-903-605 "),
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
