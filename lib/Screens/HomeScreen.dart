import 'package:flutter/material.dart';
import 'package:basketballstats/Screens/TeamScreen.dart';
import 'package:basketballstats/Widgets/TeamContainer.dart';
//import 'package:awesome_package/awesome_package.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  // ignore: non_constant_identifier_names
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              const Color(0xff29b6f6),
              const Color(0xff29b6f6),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          )),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'PACIFIC DIVISION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white ,
                    fontSize: 30,
                    fontFamily: 'Raleway',
                    package: 'awesome_package',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  children: [
                    GestureDetector(
                      child: TeamContainer(image: 'assets/clippers.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(code: 'CLI'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: TeamContainer(image: 'assets/lakers.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(code: 'LAL'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: TeamContainer(image: 'assets/suns.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(code: 'PHX'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: TeamContainer(image: 'assets/warriors.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(code: 'GSW'),
                            ));
                      },
                    ),
                    GestureDetector(
                      child: TeamContainer(image: 'assets/kings.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeamScreen(code: 'SAC'),
                            ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
