import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles {
  static getTitleData() => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        reservedSize: 20, //bottomspace
        getTextStyles: (value, _) {
          return const TextStyle(
              color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 15);
        },

        getTitles: (value) {
          switch (value.toInt()) {
            case 0:
              return 'Jan';
            case 1:
              return 'Feb';
            case 2:
              return 'Mar';
            case 3:
              return 'Apr';
            case 4:
              return 'May';
            case 5:
              return 'Jun';
            case 6:
              return 'Jul';
            case 7:
              return 'Aug';
            case 8:
              return 'Sep';
            case 9:
              return 'Oct';
            case 10:
              return 'Nov';
            case 11:
              return 'Dec';
          }
          return '';
        },
        margin: 8,
      ),
      topTitles: SideTitles(
        showTitles: false,
      ));
}
