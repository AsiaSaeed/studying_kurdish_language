import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:studying_kurdish_language/Listener/circle_the_letter_widget_listner.dart';
import 'package:audioplayers/audioplayers.dart';

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
  double textSize = 30;
  var textChangedSize = [30.0,30.0,30.0,30.0];
  RichText richText;
  @override
  Widget build(BuildContext context) {
    heightUnit = MediaQuery.of(context).size.height / 5;
    widthUnit = MediaQuery.of(context).size.width / 6;

    print(circleColors[0].toString());
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
                 CircleTheLetterListener(circleColors[index],rich(words[index], 'د', index))
                ],
              );
            },
          ),
        ),
      ),
    );
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
                    letterColors[numOfWord] = Colors.green;
                    circleColors[numOfWord] = Colors.grey;
                    textChangedSize[numOfWord] = 50;
                  });
                }),
          new TextSpan(
            text: word.substring(1, word.length),
            style: TextStyle(
              color: Colors.black,
              fontSize: textSize,
            ),
            recognizer: TapGestureRecognizer() ..onTap=() {

            }

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
                      letterColors[numOfWord] = Colors.green;
                      circleColors[numOfWord] = Colors.grey;
                      textChangedSize[numOfWord] = 50;
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
                      letterColors[numOfWord] = Colors.green;
                      circleColors[numOfWord] = Colors.grey;
                      textChangedSize[numOfWord] = 50;

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