import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class TableScreen extends StatefulWidget {
  final String code;

  const TableScreen({Key key, this.code}) : super(key: key);
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  List _table;

  getTable() async {
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
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return _table == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFe70066),
                ),
              ),
            ),
          )
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  const Color(0xffe84860),
                  const Color(0xffe70066),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              )),
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
                ],
              ),
            ),
    );
  }
}
