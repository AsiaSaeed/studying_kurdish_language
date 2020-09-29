import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CircleTheLetter extends StatefulWidget {
  @override
  _CircleTheLetterState createState() => _CircleTheLetterState();
}

class _CircleTheLetterState extends State<CircleTheLetter> {
  var widthUnit;
  var heightUnit;
  double positionX = 0;
  double positionY = 0;
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
  var textChangedSize = [30.0, 30.0, 30.0, 30.0];
  RichText richText;
  var _key = [
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
    new GlobalKey(),
  ];
  Offset _offset0;
  Offset _offset1;
  Offset _offset2;
  Offset _offset3;
  Offset _offset;

  RenderBox render;
  RenderBox render0;
  RenderBox render1;
  RenderBox render2;
  RenderBox render3;

  @override
  Widget build(BuildContext context) {
    heightUnit = MediaQuery.of(context).size.height / 5;
    widthUnit = MediaQuery.of(context).size.width / 6;
    return Scaffold(
        body: Center(
      child: ListView.builder(
        itemCount: words.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: MediaQuery.of(context).size.width - 16,
            child: Listener(
              onPointerDown: (PointerDownEvent event) {
                render = _key[index].currentContext.findRenderObject();
                Offset offset;

                switch (index) {
                  case 0:
                    render0 = _key[index].currentContext.findRenderObject();
                    offset = render0.globalToLocal(event.position);
                    setState(() {
                      if(letterColors[index]!=Colors.green)
                      _offset0 = offset;
                      _offset = _offset0;
                    });

                    break;
                  case 1:
                    render1 = _key[index].currentContext.findRenderObject();
                    offset = render1.globalToLocal(event.position);
                    setState(() {
                      if(letterColors[index]!=Colors.green);
                      _offset =offset;
                    });

                    break;
                  case 2:
                    render2 = _key[index].currentContext.findRenderObject();
                    offset = render2.globalToLocal(event.position);
                    setState(() {
                      if(letterColors[index]!=Colors.green)
                      _offset = offset;
                    });

                    break;
                  case 3:
                    render3 = _key[index].currentContext.findRenderObject();
                    offset = render3.globalToLocal(event.position);
                    setState(() {
                      if(letterColors[index]!=Colors.green)
                      _offset = offset;
                    });
                    break;
                }
                ;
              },
              child: new CustomPaint(
                key: _key[index],
                painter: new MyCustomPainter(_offset),
                child: Center(
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Image.asset('asset/sound.png'),
                        onTap: () {},
                      ),
                      rich(words[index], 'د', index)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
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
              style: (TextStyle(
                  color: letterColor, fontSize: textChangedSize[numOfWord])),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    letterColors[numOfWord] = Colors.green;
                    circleColors[numOfWord] = Colors.black;
                    textChangedSize[numOfWord] = 50;
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
                style: (TextStyle(
                    color: letterColor, fontSize: textChangedSize[numOfWord])),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      letterColors[numOfWord] = Colors.green;
                      circleColors[numOfWord] = Colors.black;
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
                style: (TextStyle(
                    color: letterColor, fontSize: textChangedSize[numOfWord])),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      letterColors[numOfWord] = Colors.green;
                      circleColors[numOfWord] = Colors.black;
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

class MyCustomPainter extends CustomPainter {
  final Offset _offset;

  MyCustomPainter(this._offset);

  @override
  void paint(Canvas canvas, Size size) {
    if (_offset == null) return;
    canvas.drawCircle(_offset, 15.0, new Paint()..color = Colors.grey);
  }

  @override
  bool shouldRepaint(MyCustomPainter other) => other._offset != _offset;
}
