import 'dart:convert';
import 'package:basketballstats/Widgets/ChartData.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;


class TeamScreen extends StatefulWidget {
  final String code;
  const TeamScreen({Key key, this.code}) : super(key: key);
  @override
  _TeamScreenState createState() => _TeamScreenState();
}
class _TeamScreenState extends State<TeamScreen> with SingleTickerProviderStateMixin {
  final List<Widget> myTabs = [
    Tab(icon: Icon(FontAwesomeIcons.solidChartBar)),
    Tab(icon: Icon(FontAwesomeIcons.chartPie)),
    Tab(icon: Icon(FontAwesomeIcons.chartLine)),
  ];

  TabController _tabController;
  List<charts.Series<BarSeries, String>> _seriesBarData;
  List<charts.Series<PieSeries, String>> _seriesPieData;
  List<charts.Series<LineSeries, int>> _seriesLineData;
  List _table;
  List _chartdata;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List> getData() async {
    http.Response response = await http.get(
        'https://bball-stats-api.herokuapp.com/${widget.code}');
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['stats'];
    List chartdata = data['chartdata'];
    print(chartdata);
    setState(() {
      _table = table;
      _chartdata = chartdata;
    });
    return _chartdata;
  }

  _generateData() async {
    Future<List> futlist = getData();
    List chdata = await futlist;
    print(chdata);

    var data1 = [
      new BarSeries("2015-16",  chdata[4],  charts.ColorUtil.fromDartColor(Colors.red)),
      new BarSeries("2016-17",  chdata[3], charts.ColorUtil.fromDartColor(Colors.red)),
      new BarSeries("2017-18",  chdata[2], charts.ColorUtil.fromDartColor(Colors.red)),
      new BarSeries("2018-19",  chdata[1], charts.ColorUtil.fromDartColor(Colors.red)),
      new BarSeries("2019-20",  chdata[0], charts.ColorUtil.fromDartColor(Colors.red)),
    ];
    _seriesBarData.add(
      charts.Series(
        domainFn: (BarSeries barseries, _) => barseries.season,
        measureFn: (BarSeries barseries, _) => num.parse(barseries.piedata),
        colorFn: (BarSeries barseries, _) => barseries.barColor,
        id: "piedata",
        data: data1,
      ),
    );

    var piedata = [
      new PieSeries('Win (%)', chdata[5]['winper'], charts.ColorUtil.fromDartColor(Colors.red)),
      new PieSeries('Loss (%)', chdata[5]['lossper'], charts.ColorUtil.fromDartColor(Colors.grey)),

    ];
    _seriesPieData.add(
      charts.Series(

        domainFn: (PieSeries task, _) => task.task,
        measureFn: (PieSeries task, _) => task.taskvalue,
        colorFn: (PieSeries task, _) => task.colorval,
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (PieSeries row, _) => '${row.taskvalue}',
      ),
    );

    var linedata = [
      new LineSeries(0, chdata[6]['15-163pm']),
      new LineSeries(1, chdata[6]['16-173pm']),
      new LineSeries(2, chdata[6]['17-183pm']),
      new LineSeries(3, chdata[6]['18-193pm']),
      new LineSeries(4, chdata[6]['19-203pm']),

    ];
    var linedata1 = [
      new LineSeries(0, chdata[6]['15-163pa']),
      new LineSeries(1, chdata[6]['16-173pa']),
      new LineSeries(2, chdata[6]['17-183pa']),
      new LineSeries(3, chdata[6]['18-193pa']),
      new LineSeries(4, chdata[6]['19-203pa']),

    ];


    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xfff44336)),
        id: '',
        data: linedata,
       domainFn: (LineSeries sales, _) => sales.yearval,
        measureFn: (LineSeries sales, _) => sales.salesval,
        labelAccessorFn: (LineSeries row, _) => '${row.yearval}',
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffeeff41)),
        id: '',
        data: linedata1,
       domainFn: (LineSeries sales, _) => sales.yearval,
        measureFn: (LineSeries sales, _) => sales.salesval,
        labelAccessorFn: (LineSeries row, _) => '${row.yearval}',
      ),
    );

  }
 /* Widget drawChart() {
    final List<ChartSeries> data = [
      ChartSeries(
        season: "2015-16",
        piedata: _chartdata[4],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2016-17",
        piedata: _chartdata[3],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2017-18",
        piedata: _chartdata[2],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2018-19",
        piedata: _chartdata[1],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2019-20",
        piedata: _chartdata[0],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];
    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
          id: "piedata",
          data: data,
          domainFn: (ChartSeries series, _) => series.season,
          measureFn: (ChartSeries series, _) => num.parse(series.piedata) ,
          colorFn: (ChartSeries series, _) => series.barColor),
    ];
    return Container(
      height: 500,
      padding: EdgeInsets.all(20),
      child: Card(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "PLAYER  IMPACT  ESTIMATE",
                style: TextStyle(
                  color: Colors.white ,
                  fontSize: 15,
                  fontFamily: 'Raleway',
                  package: 'awesome_package',
                )
              ),
              Expanded(
                child: charts.BarChart(series, animate: true),
              )
            ],
          ),
        ),
      ),
    );
  }*/

  Widget buildTable() {
    List<Widget> row = [];
    for (var team in _table) {
      row.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['season'].toString(),
                        style: TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                    Text(team['offrtg'].toString(),style:TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                    Text('   '+ team['defrtg'].toString(),
                        style:TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                    Text('  ' + team['astto'].toString(),
                        style:TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                    Text(team['pace'].toString(),
                        style:TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: row,
    );
  }
  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }
  @override
  void  initState  () {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);
    _seriesBarData = List<charts.Series<BarSeries, String>>();
    _seriesPieData = List<charts.Series<PieSeries, String>>();
    _seriesLineData = List<charts.Series<LineSeries, int>>();
    _generateData();
    getData();
  }
  final customTickFormatter =
  charts.BasicNumericTickFormatterSpec((num value) {
    if (value == 0) {
      return "2015-16";
    } else if (value == 1) {
      return "2016-17";
    } else if (value == 2) {
      return "2017-18";
    } else if (value == 3) {
      return "2018-19";
    } else if (value == 4) {
      return "2019-20";
    }
  });

  @override
  Widget build(BuildContext context) {
   /* final List<ChartSeries> data = [
      ChartSeries(
        season: "2015-16",
        piedata: _chartdata[4],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2016-17",
        piedata: _chartdata[3],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2017-18",
        piedata: _chartdata[2],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2018-19",
        piedata: _chartdata[1],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
      ChartSeries(
        season: "2019-20",
        piedata: _chartdata[0],
        barColor: charts.ColorUtil.fromDartColor(Colors.red),
      ),
    ];
    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
          id: "piedata",
          data: data,
          domainFn: (ChartSeries series, _) => series.season,
          measureFn: (ChartSeries series, _) => num.parse(series.piedata) ,
          colorFn: (ChartSeries series, _) => series.barColor),
    ];*/
    return _table  == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xfff44336),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              color: Colors.lightBlue,
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: <Widget> [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                'Season',
                                style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 13,
                                  fontFamily: 'Raleway',
                                  package: 'awesome_package',),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '      OFFRTG',
                                style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 13,
                                  fontFamily: 'Raleway',
                                  package: 'awesome_package',),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'DEFRTG',
                                style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 13,
                                  fontFamily: 'Raleway',
                                  package: 'awesome_package',),
                              ),
                              Text(
                                ' AST/TO',
                                style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 13,
                                  fontFamily: 'Raleway',
                                  package: 'awesome_package',),
                              ),
                              Text(
                                'PACE',
                                style: TextStyle(
                                  color: Colors.white ,
                                  fontSize: 13,
                                  fontFamily: 'Raleway',
                                  package: 'awesome_package',),
                              ),

                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  buildTable(),

                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.redAccent,
                    tabs: myTabs,
                  ),
                  Center(
                    child: [
                      Column(
                        children: [
                          Container(
                            height: 500,
                            padding: EdgeInsets.all(20),
                            child: Card(
                            color: Colors.lightBlue,
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                      children: <Widget>[
                                           Text(
                                            "PLAYER  IMPACT  ESTIMATE",
                                            style: TextStyle(
                                          color: Colors.white ,
                                          fontSize: 15,
                                          fontFamily: 'Raleway',
                                          package: 'awesome_package',
                                                     )
                                                  ),
                                              Expanded(
                                                  child: charts.BarChart(_seriesBarData, animate: true),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                        ],
                      ),
                      SizedBox(
                        height:500,
                        width:500,
                        child: Column(
                        children: <Widget>[
                          Text(
                            'All-time Win/Loss ',style: TextStyle(fontSize: 24.0,color:Colors.white, fontFamily: 'Raleway',package:'awesome_package'),),
                          SizedBox(height: 10.0,),
                          Expanded(
                            child: charts.PieChart(
                                _seriesPieData,
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                behaviors: [
                                  new charts.DatumLegend(
                                    outsideJustification: charts.OutsideJustification.endDrawArea,
                                    horizontalFirst: false,
                                    desiredMaxRows: 2,
                                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                                    entryTextStyle: charts.TextStyleSpec(
                                        color: charts.MaterialPalette.white,
                                        fontFamily: 'Georgia',
                                        fontSize: 15),
                                  )
                                ],
                                defaultRenderer: new charts.ArcRendererConfig(
                                    arcWidth: 50,
                                    arcRendererDecorators: [
                                      new charts.ArcLabelDecorator(
                                          labelPosition: charts.ArcLabelPosition.inside)
                                    ])),
                          ),
                        ],
                      ),
                         ),
                      SizedBox(
                        height:500,
                        width:450,
                     child: Column(
                       children: <Widget>[
                          Text(
                            '3PT Attempts - 3PT Made (%)',style: TextStyle(fontSize: 24.0,color:Colors.white, fontFamily: 'Raleway',package:'awesome_package'),),
                          Expanded(
                            child: charts.LineChart(
                                _seriesLineData,
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 5),
                                primaryMeasureAxis: new charts.NumericAxisSpec(
                                  tickProviderSpec:
                                  new charts.BasicNumericTickProviderSpec(desiredTickCount: 4),
                                ),
                                domainAxis: charts.NumericAxisSpec(
                                  tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(desiredTickCount: 5),
                                  tickFormatterSpec: customTickFormatter,
                                ),
                                behaviors: [
                                  new charts.ChartTitle('Years',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Percentage',
                                      behaviorPosition: charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),

                                ]
                            ),
                          ),
                        ],
                      ),
                      ),
                    ][_tabController.index],
                  ),
                ],
              ),
            ),
    );
  }
}
