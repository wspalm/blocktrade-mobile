import 'package:flutter/material.dart';

final demoStock = [
  "DELTA",
  "CPALL",
  "CV",
  "GULF",
  "ADVANC",
  "MAKRO",
  "KBANK",
  "RPG",
  "SCB",
  "PTT",
  "ABPIF",
  "NOBLE",
  "BRRGIF",
  "LPN",
  "TRUE",
  "SUPER",
  "GUNKUL",
  "SIRI"
];
final recommendStock = ["SCB", "PTT", "ABPIF", "NOBLE", "BRRGIF", "LPN"];

class SearchData extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // implement buildActions
    // action for app bar
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    // implement buildLeading
    // leading icon on the left of the app bar
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // implement buildResults
    // show some result based on the selection
    return Align(
        alignment: Alignment.center,
        child: Text(
          query,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = query.isEmpty
        ? recommendStock
        : demoStock.where((stock) {
            final stockLower = stock.toLowerCase();
            final queryLower = query.toLowerCase();

            return stockLower.startsWith(queryLower);
          }).toList();

    return suggestions.isEmpty
        ? NotFound()
        : buildSuggestionsSuccess(suggestions);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              // 1. Show Results
              showResults(context);

              // 2. Close Search & Return Result
              // close(context, suggestion);

              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            leading: Icon(Icons.location_city),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.brown.shade300,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}

class NotFound extends StatelessWidget {
  const NotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Text(
          "No results found . . .",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ));
  }
}
