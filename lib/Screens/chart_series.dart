import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';

class ChartSeries {
  final String year;
  final int subscribers;
  final charts.Color barColor;

 ChartSeries(
      {@required this.year,
        @required this.subscribers,
        @required this.barColor,
        });
}