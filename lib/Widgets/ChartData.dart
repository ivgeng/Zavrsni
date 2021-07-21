import 'package:charts_flutter/flutter.dart' as charts;

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

final customTickFormatter =
// ignore: missing_return
charts.BasicNumericTickFormatterSpec((num value) {
  if (value == 0) {
    return "2015-16";
  }
  else if (value == 1) {
    return "2016-17";
  }
  else if (value == 2) {
    return "2017-18";
  }
  else if (value == 3) {
    return "2018-19";
  }
  else if (value == 4) {
    return "2019-20";
  }
});

