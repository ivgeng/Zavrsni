import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartSeries {
  final String season;
  final String piedata;
  final charts.Color barColor;

 ChartSeries(
      {@required this.season,
        @required this.piedata,
        @required this.barColor,
        });
}