import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class BarSeries {
  String season;
  String piedata;
  charts.Color barColor;

  BarSeries(this.season, this.piedata, this.barColor);
}

class PieSeries {
  String task;
  double taskvalue;
  charts.Color colorval;

 PieSeries(this.task,  this.taskvalue, this.colorval);
}

class  LineSeries {
  int yearval;
  num salesval;

  LineSeries(this.yearval, this.salesval);
}

