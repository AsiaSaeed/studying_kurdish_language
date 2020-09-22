import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleTheLetter extends StatefulWidget {
  @override
  _CircleTheLetterState createState() => _CircleTheLetterState();
}

class _CircleTheLetterState extends State<CircleTheLetter> {
  var widthUnit;
  var heightUnit;

  @override
  Widget build(BuildContext context) {
    heightUnit=MediaQuery.of(context).size.height/5;
    widthUnit=MediaQuery.of(context).size.width/6;
    return Scaffold(
        body: Center(
          child: Container(
            width: widthUnit*4,
            height: heightUnit*3,
            //child: ListView,
          ),
        ),
    );
  }
}
