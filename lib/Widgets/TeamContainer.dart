import 'package:flutter/material.dart';

class TeamContainer extends StatelessWidget {
  final String image;

  const TeamContainer({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Image.asset(image),
    );
  }
}
