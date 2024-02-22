// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class LineChartSample6 extends StatelessWidget {
//   LineChartSample6({
//     super.key,
//     Color? line1Color1,
//     Color? line1Color2,
//     Color? line2Color1,
//     Color? line2Color2,
//   })  : line1Color1 = line1Color1 ?? Colors.orange,
//         line1Color2 = line1Color2 ?? Colors.green,
//         line2Color1 = line2Color1 ?? Colors.pink,
//         line2Color2 = line2Color2 ?? Colors.lightBlue {
//     minSpotX = spots.first.x;
//     maxSpotX = spots.first.x;
//     minSpotY = spots.first.y;
//     maxSpotY = spots.first.y;

//     for (final spot in spots) {
//       if (spot.x > maxSpotX) {
//         maxSpotX = spot.x;
//       }

//       if (spot.x < minSpotX) {
//         minSpotX = spot.x;
//       }

//       if (spot.y > maxSpotY) {
//         maxSpotY = spot.y;
//       }

//       if (spot.y < minSpotY) {
//         minSpotY = spot.y;
//       }
//     }
//   }

//   final Color line1Color1;
//   final Color line1Color2;
//   final Color line2Color1;
//   final Color line2Color2;

//   final spots = const [
//     FlSpot(0, 1),
//     FlSpot(2, 5),
//     FlSpot(4, 3),
//     FlSpot(6, 5),
//   ];

//   final spots2 = const [
//     FlSpot(0, 3),
//     FlSpot(2, 1),
//     FlSpot(4, 2),
//     FlSpot(6, 1),
//   ];

//   late double minSpotX;
//   late double maxSpotX;
//   late double minSpotY;
//   late double maxSpotY;

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     final style = TextStyle(
//       color: line1Color1,
//       fontWeight: FontWeight.bold,
//       fontSize: 18,
//     );

//     final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

//     if (intValue == (maxSpotY + minSpotY)) {
//       return Text('', style: style);
//     }

//     return Padding(
//       padding: const EdgeInsets.only(right: 6),
//       child: Text(
//         intValue.toString(),
//         style: style,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget rightTitleWidgets(double value, TitleMeta meta) {
//     final style = TextStyle(
//       color: line2Color2,
//       fontWeight: FontWeight.bold,
//       fontSize: 18,
//     );
//     final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

//     if (intValue == (maxSpotY + minSpotY)) {
//       return Text('', style: style);
//     }

//     return Text(intValue.toString(), style: style, textAlign: TextAlign.right);
//   }

//   Widget topTitleWidgets(double value, TitleMeta meta) {
//     if (value % 1 != 0) {
//       return Container();
//     }
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       color: Colors.grey,
//     );
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       child: Text(value.toInt().toString(), style: style),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: AspectRatio(
//         aspectRatio: 2,
//         child: LineChart(
//           LineChartData(
//             lineTouchData: LineTouchData(enabled: true),
//             lineBarsData: [
//               LineChartBarData(
//                 gradient: LinearGradient(
//                   colors: [
//                     line1Color1,
//                     line1Color2,
//                   ],
//                 ),
//                 spots: reverseSpots(spots, minSpotY, maxSpotY),
//                 isCurved: true,
//                 isStrokeCapRound: true,
//                 barWidth: 10,
//                 belowBarData: BarAreaData(
//                   show: false,
//                 ),
//                 dotData: FlDotData(
//                   show: true,
//                   getDotPainter: (spot, percent, barData, index) =>
//                       FlDotCirclePainter(
//                     radius: 12,
//                     color: Colors.transparent,
//                     strokeColor: Colors.grey,
//                   ),
//                 ),
//               ),
//               LineChartBarData(
//                 gradient: LinearGradient(
//                   colors: [
//                     line2Color1,
//                     line2Color2,
//                   ],
//                 ),
//                 spots: reverseSpots(spots2, minSpotY, maxSpotY),
//                 isCurved: true,
//                 isStrokeCapRound: true,
//                 barWidth: 10,
//                 belowBarData: BarAreaData(
//                   show: false,
//                 ),
//                 dotData: FlDotData(
//                   show: true,
//                   getDotPainter: (spot, percent, barData, index) =>
//                       FlDotCirclePainter(
//                     radius: 12,
//                     color: Colors.transparent,
//                     strokeColor: Colors.lime,
//                   ),
//                 ),
//               ),
//             ],
//             minY: 0,
//             maxY: maxSpotY + minSpotY,
//             titlesData: FlTitlesData(
//               leftTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               rightTitles: AxisTitles(
//                 sideTitles: SideTitles(
//                   showTitles: true,
//                   getTitlesWidget: rightTitleWidgets,
//                   reservedSize: 30,
//                 ),
//               ),
//               bottomTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//               topTitles: AxisTitles(
//                 sideTitles: SideTitles(showTitles: false),
//               ),
//             ),
//             gridData: FlGridData(
//               show: true,
//               drawVerticalLine: false,
//               checkToShowHorizontalLine: (value) {
//                 final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

//                 if (intValue == (maxSpotY + minSpotY).toInt()) {
//                   return false;
//                 }

//                 return true;
//               },
//             ),
//             borderData: FlBorderData(
//               show: true,
//               border: const Border(
//                 left: BorderSide(color: Colors.orange),
//                 top: BorderSide(color: Colors.green),
//                 bottom: BorderSide(color: Colors.transparent),
//                 right: BorderSide(color: Colors.transparent),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double reverseY(double y, double minX, double maxX) {
//     return (maxX + minX) - y;
//   }

//   List<FlSpot> reverseSpots(List<FlSpot> inputSpots, double minY, double maxY) {
//     return inputSpots.map((spot) {
//       return spot.copyWith(y: (maxY + minY) - spot.y);
//     }).toList();
//   }
// }

// extension ColorExtension on Color {
//   /// Convert the color to a darken color based on the [percent]
//   Color darken([int percent = 40]) {
//     assert(1 <= percent && percent <= 100);
//     final value = 1 - percent / 100;
//     return Color.fromARGB(
//       alpha,
//       (red * value).round(),
//       (green * value).round(),
//       (blue * value).round(),
//     );
//   }

//   Color lighten([int percent = 40]) {
//     assert(1 <= percent && percent <= 100);
//     final value = percent / 100;
//     return Color.fromARGB(
//       alpha,
//       (red + ((255 - red) * value)).round(),
//       (green + ((255 - green) * value)).round(),
//       (blue + ((255 - blue) * value)).round(),
//     );
//   }

//   Color avg(Color other) {
//     final red = (this.red + other.red) ~/ 2;
//     final green = (this.green + other.green) ~/ 2;
//     final blue = (this.blue + other.blue) ~/ 2;
//     final alpha = (this.alpha + other.alpha) ~/ 2;
//     return Color.fromARGB(alpha, red, green, blue);
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:sticky_headers/sticky_headers.dart';

// class Example2 extends StatelessWidget {
//   const Example2({
//     Key? key,
//     this.controller,
//   }) : super(key: key);

//   final ScrollController? controller;

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldWrapper(
//       wrap: controller == null,
//       title: 'Example 2',
//       child: ListView.builder(
//         primary: controller == null,
//         controller: controller,
//         itemBuilder: (context, index) {
//           return StickyHeaderBuilder(
//             controller: controller, // Optional
//             builder: (BuildContext context, double stuckAmount) {
//               stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);
//               return Container(
//                 height: 50.0,
//                 color:
//                     Color.lerp(Colors.blue[700], Colors.red[700], stuckAmount),
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 alignment: Alignment.centerLeft,
//                 child: Row(
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                         'Header #$index',
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     Offstage(
//                       offstage: stuckAmount <= 0.0,
//                       child: Opacity(
//                         opacity: stuckAmount,
//                         child: IconButton(
//                           icon: const Icon(Icons.favorite, color: Colors.white),
//                           onPressed: () => ScaffoldMessenger.of(context)
//                               .showSnackBar(
//                                   SnackBar(content: Text('Favorite #$index'))),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//             content: Container(
//                 color: Colors.grey[300],
//                 child: Center(
//                   child: Container(
//                     height: 300,
//                     width: 300,
//                     child: Center(child: Text("a")),
//                   ),
//                 )
//                 // Image.network(
//                 //   imageForIndex(index),
//                 //   fit: BoxFit.cover,
//                 //   width: double.infinity,
//                 //   height: 200.0,
//                 // ),
//                 ),
//           );
//         },
//       ),
//     );
//   }

//   // String imageForIndex(int index) {
//   //   return Images.imageThumbUrls[index % Images.imageThumbUrls.length];
//   // }
// }

// class ScaffoldWrapper extends StatelessWidget {
//   const ScaffoldWrapper({
//     Key? key,
//     required this.title,
//     required this.child,
//     this.wrap = true,
//   }) : super(key: key);

//   final Widget child;
//   final String title;
//   final bool wrap;

//   @override
//   Widget build(BuildContext context) {
//     if (wrap) {
//       return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(kToolbarHeight),
//           child: Hero(
//             tag: 'app_bar',
//             child: AppBar(
//               title: Text(title),
//               elevation: 0.0,
//             ),
//           ),
//         ),
//         body: child,
//       );
//     } else {
//       return Material(
//         child: child,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';

import 'datepicker.dart';
import 'imageMapping.dart';

class Example2 extends StatelessWidget {
  const Example2({
    Key? key,
    this.controller,
  }) : super(key: key);

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return ScaffoldWrapper(
      wrap: controller == null,
      child: ListView.builder(
        primary: controller == null,
        controller: controller,
        itemBuilder: (context, index) {
          String headerText = "Header #$index";
          if (index == 0) {
            headerText = "My Reports";
          } else {
            headerText = "Student Reports";
          }

          return StickyHeaderBuilder(
            controller: controller, // Optional
            builder: (BuildContext context, double stuckAmount) {
              stuckAmount = 1.0 - stuckAmount.clamp(0.0, 1.0);

              void handleHeaderAction() {
                if (headerText == "My Reports") {
                  DatePicker();
                  // Call a function or perform an action specific to "My Reports".
                  // For example: myReportsFunction();
                } else {
                  // Call a function or perform an action specific to "Student Reports".
                  // For example: studentReportsFunction();
                  imageMapping();
                }
              }

              return GestureDetector(
                onTap:
                    handleHeaderAction, // Call the appropriate function based on the header text.
                child: Container(
                  height: 50.0,
                  color: Color.lerp(Colors.blue[700], Colors.red[700],
                      stuckAmount), //Header Colors

                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          headerText,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Offstage(
                        offstage: stuckAmount <= 1.0,
                        child: Opacity(
                          opacity: stuckAmount,
                          child: IconButton(
                            icon:
                                const Icon(Icons.favorite, color: Colors.white),
                            onPressed: handleHeaderAction,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            content: Container(
              color: Colors.grey[300],
              child: Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Center(child: Text("a")),
                ),
              ),
              // Image.network(
              //   imageForIndex(index),
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: 200.0,
              // ),
            ),
          );
        },
      ),
    );
  }
}

class ScaffoldWrapper extends StatelessWidget {
  const ScaffoldWrapper({
    Key? key,
    required this.child,
    this.wrap = true,
  }) : super(key: key);

  final Widget child;

  final bool wrap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Hero(
          tag: 'app_bar',
          child: AppBar(
            title: Text("title"),
            elevation: 0.0,
          ),
        ),
      ),
      body: child,
    );
  }
}
