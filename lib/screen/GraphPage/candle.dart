import 'package:blocktrade/screen/GraphPage/model/candledata.dart';
import 'package:blocktrade/store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';
import 'package:provider/provider.dart';

class CandlePage extends StatefulWidget {
  @override
  _CandlePageState createState() => _CandlePageState();
}

class _CandlePageState extends State<CandlePage> {
  List<CandleData> _data = MockData.candles;

  @override
  Widget build(BuildContext context) {
    var store1 = Provider.of<Store>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Interactive Chart Demo"),
        actions: [
          IconButton(
            icon: Icon(
              store1.showAverage ? Icons.show_chart : Icons.bar_chart_outlined,
            ),
            onPressed: () {
              store1.toggleShowAverage();
              if (store1.showAverage) {
                CandleData.computeMA(_data, 7);
              } else {
                CandleData.deleteMA(_data);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(24.0),
        child: InteractiveChart(
          /** Only [candles] is required */
          candles: _data,
          /** Uncomment the following for examples on optional parameters */

          /** Example styling */
          // style: ChartStyle(
          //   priceGainColor: Colors.teal[200]!,
          //   priceLossColor: Colors.blueGrey,
          //   volumeColor: Colors.teal.withOpacity(0.8),
          //   trendLineColor: Colors.blueGrey[200]!,
          //   priceGridLineColor: Colors.blue[200]!,
          //   priceLabelStyle: TextStyle(color: Colors.blue[200]),
          //   timeLabelStyle: TextStyle(color: Colors.blue[200]),
          //   selectionHighlightColor: Colors.red.withOpacity(0.2),
          //   overlayBackgroundColor: Colors.red[900]!.withOpacity(0.6),
          //   overlayTextStyle: TextStyle(color: Colors.red[100]),
          //   timeLabelHeight: 32,
          // ),
          /** Customize axis labels */
          timeLabel: (timestamp, visibleDataCount) => "📅",
          priceLabel: (price) => "${price.round()} 💎",
          /** Customize overlay (tap and hold to see it)
             ** Or return an empty object to disable overlay info. */
          overlayInfo: (candle) => {
            "💎": "🤚    ",
            "Hi": "${candle.high?.toStringAsFixed(2)}",
            "Lo": "${candle.low?.toStringAsFixed(2)}",
          },
          /** Callbacks */
          // onTap: (candle) => print("user tapped on $candle"),
          // onCandleResize: (width) => print("each candle is $width wide"),
        ),
      ),
    );
  }
} //ec

class GraphTableWidget extends StatelessWidget {
  final Widget child;

  const GraphTableWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: child,
        ),
      );
}

class GraphTablePageShort extends StatefulWidget {
  const GraphTablePageShort({Key? key}) : super(key: key);

  @override
  _GraphTablePageShortState createState() => _GraphTablePageShortState();
}

class _GraphTablePageShortState extends State<GraphTablePageShort> {
  // late List<Stock> stocks;
  late List<CandleData2> MockData2Row;
  // List<CandleData> _data = MockData.candles;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.MockData2Row = List.of(MockData2);
  }

  @override
  Widget build(BuildContext context) {
    return GraphTableWidget(child: buildDataTable());
  }

  Widget buildDataTable() {
    final columns = ['Open', 'High', 'Low', 'Close', 'Volumn'];

    return DataTable(
      columnSpacing: 15,
      horizontalMargin: 12,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(MockData2Row),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
            ),
            // onSort: onSort,
          ))
      .toList();

  final f1 = NumberFormat("#,##0", "en_US");

  List<DataRow> getRows(List<CandleData2> MockData2Row) =>
      MockData2Row.map((CandleData2 MockData2Row) {
        final cells = [
          MockData2Row.open,
          MockData2Row.high,
          MockData2Row.low,
          MockData2Row.close,
          f1.format(MockData2Row.volume),
        ];

        return DataRow(
          cells: getCells(cells),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((data) => DataCell(Text(
            '$data',
            style: TextStyle(fontSize: 15),
          )))
      .toList();

  // void onSort(int columnIndex, bool ascending) {
  //   if (columnIndex == 0) {
  //     _data.sort(
  //         (stock1, stock2) => compareString(ascending, stock1.sym, stock2.sym));
  //   }
  //   // else if (columnIndex == 1) {
  //   //   stocks.sort(
  //   //       (stock1, stock2) => compareString(ascending, stock1.aom, stock2.aom));
  //   // }

  //   setState(() {
  //     this.sortColumnIndex = columnIndex;
  //     this.isAscending = ascending;
  //   });
  // }

  // void onSort(int columnIndex, bool ascending) {
  //   // if (columnIndex == 0) {
  //   //   users.sort((user1, user2) =>
  //   //       compareString(ascending, user1.firstName, user2.firstName));
  //   // } else if (columnIndex == 1) {
  //   //   users.sort((user1, user2) =>
  //   //       compareString(ascending, user1.lastName, user2.lastName));
  //   // } else if (columnIndex == 2) {
  //   //   users.sort((user1, user2) =>
  //   //       compareString(ascending, '${user1.age}', '${user2.age}'));
  //   // }

  //   setState(() {
  //     this.sortColumnIndex = columnIndex;
  //     this.isAscending = ascending;
  //   });
  // }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
