import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'file:///C:/Users/it/AndroidStudioProjects/Zavrsni/lib/Widgets/ChartSeries.dart';
import 'package:http/http.dart' as http;

class TeamScreen extends StatefulWidget {
  final String code;
  const TeamScreen({Key key, this.code}) : super(key: key);
  @override
  _TeamScreenState createState() => _TeamScreenState();
}
class _TeamScreenState extends State<TeamScreen> {

  List _table;
  List _chartdata;
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
    List chartdata = data['chartdata'];
    //print(table);
    setState(() {
      _table = table;
      _chartdata = chartdata;
    });
  }

  Widget drawChart() {
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
  }

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
                    Text(team['defrtg'].toString(),
                        style:TextStyle(
                        color: Colors.white ,
                        fontSize: 14,
                        fontFamily: 'Raleway',
                        package: 'awesome_package',
                    )),
                    Text(team['astto'].toString(),
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
                  Color(0xff03a9f4),
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
                  drawChart(),
                ],
              ),
            ),
    );
  }
}
