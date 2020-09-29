
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


  var letterColors=[Colors.black,Colors.black,Colors.black,Colors.black];
  static var circleColors=[Colors.white,Colors.white,Colors.white,Colors.white];
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
  var xOffset=0.0;
  var yOffset=0.0;
  TapPosition _position = TapPosition(Offset.zero, Offset.zero);
  @override
  Widget build(BuildContext context) {
    heightUnit = MediaQuery.of(context).size.height / 5;
    widthUnit = MediaQuery.of(context).size.width / 6;
    return Scaffold(
      body:      Center(
        child: Container(
          width: widthUnit * 5,
          height: heightUnit * 3,
          child: ListView.builder(


            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children:[
                  Row(
                  children: [
                    GestureDetector(
                      child: Image.asset('asset/sound.png'),
                      onTap: () {},
                    ),
                    SizedBox(
                      width: widthUnit / 4,
                    ),
                    PositionedTapDetector(
                        onTap: onTap,
                      child: rich(words[index], 'د', index)),
                    CustomPaint(
                      painter: CirclePainter(_position.global.dx,_position.global.dy,circleColors[index]),
                    ),
                  ],


                ),
                ]
              );
            },
          ),
        ),
      ),
    );

  }
  void onTap(TapPosition position){
    xOffset=position.global.dx;
    yOffset=position.global.dy;
  }
  void _onTap(TapPosition position) => _updateState(position);
  void _updateState(TapPosition position) {
    setState(() {
      _position = position;
    });
  }


  Widget rich(String cWord, String cLetter, int numOfWord) {
    letterColor=letterColors[numOfWord];
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

class CirclePainter extends CustomPainter {
  var xOffset;
  var yOffset;
  static var color;
  CirclePainter(var x, var y,var colorCircle) {
    color=colorCircle;
    xOffset =x;
    yOffset =y;
  }

  var wavePaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(xOffset,yOffset), 7.0, wavePaint);

  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return false;
  }
}
