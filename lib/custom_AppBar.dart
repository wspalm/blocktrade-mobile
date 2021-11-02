import 'package:badges/badges.dart';
import 'package:blocktrade/search_page.dart';
import 'package:flutter/material.dart';

//standard AppBar
//partfolio_page , more_page
//activeTab == 0,4 ==> Bar 0
AppBar bar0 = new AppBar(
  title: Container(
    margin: EdgeInsets.only(left: 101),
    // padding: EdgeInsets.symmetric(horizontal: 105),
    child: Text(
      "Globlex",
      style: TextStyle(color: Colors.grey),
    ),
  ),
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.grey),
  elevation: 0,
  actions: [
    //badge icon tob show how many product in the order
    Badge(
      position: BadgePosition.topStart(start: -1, top: 0),
      borderRadius: BorderRadius.circular(8),
      badgeContent: Text("2", style: TextStyle(color: Colors.white)),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications,
          size: 30,
        ),
      ),
    )
  ],
);

//Search AppBar
//graph_page , order_history_page
//activeTap == 1,3 ==> Bar 1
AppBar bar1 = new AppBar(
  title: Container(
    margin: EdgeInsets.only(left: 101),
    child: Text(
      "Globlex",
      style: TextStyle(color: Colors.grey),
    ),
  ),
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.grey),
  elevation: 0,
  actions: [
    //badge icon tob show how many product in the order
    SearchAppBar()
  ],
);

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          // onPressed: () => print("search") ,
          onPressed: () {
            showSearch(context: context, delegate: SearchData());
          },
          icon: Icon(
            Icons.search,
            color: Colors.grey,
            size: 30,
          ),
        ),
        Badge(
          position: BadgePosition.topStart(start: -1, top: 0),
          borderRadius: BorderRadius.circular(8),
          badgeContent: Text("2", style: TextStyle(color: Colors.white)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

//Non Notification AppBar
//Order Page AppBar
//activeTab == 2 ==> Bar 2
AppBar bar2 = new AppBar(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.grey),
  elevation: 0,
);
