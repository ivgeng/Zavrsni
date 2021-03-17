import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:footballapp/Screens/chart_series.dart';
import 'package:http/http.dart' as http;

class TableScreen extends StatefulWidget {
  final String code;

  const TableScreen({Key key, this.code}) : super(key: key);
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List _table;
  final List<ChartSeries> data = [
    ChartSeries(
      year: "2011",
      subscribers: 10000000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartSeries(
      year: "2012",
      subscribers: 8500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartSeries(
      year: "2013",
      subscribers: 7700000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartSeries(
      year: "2014",
      subscribers: 7600000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
    ChartSeries(
      year: "2015",
      subscribers: 5500000,
      barColor: charts.ColorUtil.fromDartColor(Colors.red),
    ),
  ];
  Widget drawChart() {
    List<charts.Series<ChartSeries, String>> series = [
      charts.Series(
          id: "Subscribers",
          data: data,
          domainFn: (ChartSeries series, _) => series.year,
          measureFn: (ChartSeries series, _) => series.subscribers,
          colorFn: (ChartSeries series, _) => series.barColor),
    ];
    return Container(
      height: 400,
      padding: EdgeInsets.all(1),
      child: Card(
        color: Colors.lightBlue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "DATA",
                style: Theme.of(context).textTheme.title,

              ),
              Expanded(
                child: charts.BarChart(series, animate: true),

              )
            ],
          ),
        ),
      ),
    );
  }

  getData() async {
    http.Response response = await http.get(
        'https://bball-stats-api.herokuapp.com/${widget.code}');
    String body = response.body;
   // JsonEncoder encoder = new JsonEncoder.withIndent('  ');
   // String prettyprint = encoder.convert(body);
    //print(prettyprint);
    //print(body);
    Map data = jsonDecode(body);
   // print(data);
    List table = data['stats'];
    //print(table);
    setState(() {
     _table = table;
    });
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['season'].toString()),
                    Text(team['fieldGoalPercentage'].toString()),
                    Text(team['3pointFieldGoalPercentage'].toString()),
                    Text(team['freeThrowsPercentage'].toString()),
                    Text(team['pts'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return _table == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xffff9800),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              color: Colors.lightBlue,
              /*decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color(0xff03a9f4),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),*/
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
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
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                '          FG%',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '3PT%',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'FT%',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'PTS',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
                  drawChart(),
                ],
              ),
            ),
    );

  }
}
