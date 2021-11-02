import 'package:blocktrade/screen/GraphPage/candle.dart';
import 'package:blocktrade/screen/GraphPage/model/candledata.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:interactive_chart/interactive_chart.dart';

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CandleData> _data = MockData.candles;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "SCB",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        //height: MediaQuery.of(context).size.height - 100,
                        height: 600,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    //white box 1 (filter)
                    Container(
                      //height: 70,
                      //color: Colors.grey.shade300,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: Row(
                        children: [
                          FilterButton(
                            textinfilter: 'Days',
                          ),
                          FilterButton(
                            textinfilter: 'Weeks',
                          ),
                          FilterButton(
                            textinfilter: 'Months',
                          ),
                          FilterButton(
                            textinfilter: 'Qtrs',
                          ),
                          FilterButton(
                            textinfilter: 'Years',
                          ),
                        ],
                      ),
                    ),

                    // white box 2 (Graph)
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 60),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 25, right: 25, top: 30, bottom: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        child:
                            // Graph(),
                            InteractiveChart(
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
                          // timeLabel: (timestamp, visibleDataCount) => "📅",
                          // priceLabel: (price) => "${price.round()} 💎",
                          /** Customize overlay (tap and hold to see it)
             ** Or return an empty object to disable overlay info. */
                          overlayInfo: (candle) => {
                            // "💎": "🤚",
                            "Hi": "${candle.high?.toStringAsFixed(2)}",
                            "Lo": "${candle.low?.toStringAsFixed(2)}",
                          },
                          /** Callbacks */
                          // onTap: (candle) => print("user tapped on $candle"),
                          // onCandleResize: (width) => print("each candle is $width wide"),
                        ),
                      ),
                    ),
                    //white box 3 (Details)
                    Container(
                      margin: EdgeInsets.only(
                        top: 380,
                      ),
                      width: MediaQuery.of(context).size.width,

                      height: 700,
                      //color: Colors.grey.shade300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Align(
                            alignment: Alignment.center,
                            child: GraphTablePageShort()),
                      ),
                      // SortablePageShort(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} //ec

class FilterButton extends StatelessWidget {
  final String textinfilter;
  const FilterButton({
    Key? key,
    required this.textinfilter,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 2, right: 2),
      width: 66,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: () {},
        child: Align(
            alignment: Alignment.center,
            child: Text(
              textinfilter,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
} //ec

// class Graph extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 120,
//       child: LineChart(LineChartData(
//         minX: 0,
//         maxX: 12,
//         minY: 0,
//         maxY: 12,
//         gridData: FlGridData(show: false),
//         borderData: FlBorderData(show: false),
//         titlesData: FlTitlesData(
//           //show: true,
//           leftTitles: SideTitles(showTitles: false),
//           bottomTitles: SideTitles(
//               showTitles: true,
//               //getTextStyle have 2 parameters (context, double)
//               getTextStyles: (context, double value) => const TextStyle(
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16),
//               getTitles: (value) {
//                 switch (value.toInt()) {
//                   case 0:
//                     return '0';
//                   case 1:
//                     return '1';
//                   case 2:
//                     return '2';
//                   case 3:
//                     return '3';
//                   case 4:
//                     return '4';
//                   case 5:
//                     return '5';
//                   case 6:
//                     return '6';
//                   case 7:
//                     return '7';
//                   case 8:
//                     return '8';
//                   case 9:
//                     return '9';
//                   case 10:
//                     return '10';
//                   case 11:
//                     return '11';
//                   case 12:
//                     return '12';
//                 }
//                 return '';
//               }),
//         ),
//         lineBarsData: [
//           LineChartBarData(
//               isCurved: true,
//               colors: [
//                 Color(0xFF23B6E6),
//                 Color(0xFF02D39A),
//               ],
//               barWidth: 5,
//               isStrokeCapRound: true,
//               dotData: FlDotData(show: false),
//               belowBarData: BarAreaData(show: true, colors: [
//                 ColorTween(
//                   begin: Color(0xFF23B6E6),
//                   end: Color(0xFF02D39A),
//                 ).lerp(0.1)!.withOpacity(0.1),
//               ]),
//               aboveBarData: BarAreaData(show: true, colors: [
//                 ColorTween(
//                   begin: Color(0xFF23B6E6),
//                   end: Color(0xFF02D39A),
//                 ).lerp(0.2)!.withOpacity(0.1),
//               ]),
//               spots: [
//                 FlSpot(0, 10),
//                 FlSpot(1, 3),
//                 FlSpot(2, 4),
//                 FlSpot(3, 6),
//                 FlSpot(4, 4),
//                 FlSpot(5, 6),
//                 FlSpot(6, 7),
//                 FlSpot(7, 8),
//                 FlSpot(8, 7),
//                 FlSpot(9, 8),
//                 FlSpot(10, 6),
//                 FlSpot(11, 8),
//                 FlSpot(12, 9),
//               ]),
//         ],
//       )),
//     );
//   }
// }//ec
