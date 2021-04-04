import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lebanese_ngo/stringhighlight.dart';

import 'getjsonclass.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
 Widget setconstantviewincategory() {
  return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        gradient: new LinearGradient(
            colors: [
              const Color(0xFF3ba9ce),
              const Color(0xFF0099ff),
              const Color(0xFF80d4ff),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            tileMode: TileMode.clamp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Center(
                child: Text(
                  'TIP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'It is optional to not  have fruit.In some cases minimizing or leaving out fruit leads to slightly better results.',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ));


}
