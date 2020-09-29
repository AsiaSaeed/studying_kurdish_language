import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:positioned_tap_detector/positioned_tap_detector.dart';

class CircleTheLetter extends StatefulWidget {
  @override
  _CircleTheLetterState createState() => _CircleTheLetterState();
}

class _CircleTheLetterState extends State<CircleTheLetter> {
  var widthUnit;
  var heightUnit;
  double positionX=0;
  double positionY=0;
  var letterColors = [Colors.black, Colors.black, Colors.black, Colors.black];
  static var circleColors = [
    Color(0xfffafafa),
    Color(0xfffafafa),
    Color(0xfffafafa),
    Color(0xfffafafa),
  ];
  var letterColor = Colors.black;
  var circleColor = Colors.black;
  var words = ['پەنجەرە', 'دەرگا', 'دیوار', 'ئامەد'];
  String word = "";
  String letter = "";
  String firstPart = "";
  String remainPart = "";
  int ff = 0;
  int rf = 0;
  double textSize = 40;
  RichText richText;
  TapPosition _position=TapPosition(Offset.zero,Offset.zero);
  @override
  Widget build(BuildContext context) {
    heightUnit = MediaQuery.of(context).size.height / 5;
    widthUnit = MediaQuery.of(context).size.width / 6;
    return Scaffold(
      body: Center(
        child: Container(
          width: widthUnit * 5,
          height: heightUnit * 3,
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  GestureDetector(
                    child: Image.asset('asset/sound.png'),
                    onTap: () {},
                  ),
                  CustomPaint(
                    painter: CurvePainter(circleColors[index],_position.global.dx,_position.global.dy),
                    child: Center(
                      child: PositionedTapDetector(
                        onTap: _onTap,
                        child: rich(words[index], 'د', index),
                      ),
                    ),
                  ),

                ],
              );
            },
          ),
        ),
      ),
    );
  }
  void _onTap(TapPosition position) => _updateState(position);
  void _updateState(TapPosition position) {

    setState(() {
      _position = position;

    });
    print(positionY.toString()+'hey there'+positionX.toString());
  }


  Widget rich(String cWord, String cLetter, int numOfWord) {
    letterColor = letterColors[numOfWord];
    word = cWord;
    letter = cLetter;
    if (word.startsWith(letter)) {
      richText = RichText(
          text: TextSpan(
        children: <TextSpan>[
          new TextSpan(
              text: letter,
              style: (TextStyle(color: letterColor, fontSize: textSize)),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    letterColors[numOfWord] = Colors.red;
                    circleColors[numOfWord] = Colors.black;
                  });
                }),
          new TextSpan(
            text: word.substring(1, word.length),
            style: TextStyle(
              color: Colors.black,
              fontSize: textSize,
            ),
          ),
        ],
      ));
    } else if (word.endsWith(letter)) {
      richText = RichText(
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(
                text: word.substring(0, word.length - 1),
                style: TextStyle(color: Colors.black, fontSize: textSize)),
            new TextSpan(
                text: letter,
                style: (TextStyle(color: letterColor, fontSize: textSize)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      letterColors[numOfWord] = Colors.red;
                      circleColors[numOfWord] = Colors.black;
                    });
                  }),
          ],
        ),
      );
    } else if (!word.startsWith(letter) &&
        !word.endsWith(letter) &&
        word.contains(letter)) {
      for (int i = 0; i < word.length; i++) {
        if (i < word.indexOf(letter) && ff == 0) {
          firstPart = firstPart + word[i];
          if (i == word.indexOf(letter) - 1) ff = 1;
        } else if (i > word.indexOf(letter) && rf == 0) {
          remainPart = remainPart + word[i];
          if (i == word.length - 1) rf = 1;
        }
      }
      richText = RichText(
        text: TextSpan(
          children: <TextSpan>[
            new TextSpan(
                text: firstPart,
                style: TextStyle(color: Colors.black, fontSize: textSize)),
            new TextSpan(
                text: letter,
                style: (TextStyle(color: letterColor, fontSize: textSize)),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      letterColors[numOfWord] = Colors.red;
                      circleColors[numOfWord] = Colors.black;
                    });
                  }),
            new TextSpan(
              text: remainPart,
              style: (TextStyle(color: Colors.black, fontSize: textSize)),
            ),
          ],
        ),
      );
    } else {
      richText = RichText(
        text: TextSpan(
          text: word,
          style: (TextStyle(color: Colors.black, fontSize: textSize)),
        ),
      );
    }
    return richText;
  }
}

class CurvePainter extends CustomPainter {
  var color=Colors.black;
  var offsetX;
  var offsetY;

  CurvePainter(var color,var offsetX,var offsetY){
    this.color=color;
    this.offsetX=offsetX;
    this.offsetY=offsetY;
  }
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.strokeWidth = 5;

    paint.color = color;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(offsetX,offsetY), size.width / 4, paint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
