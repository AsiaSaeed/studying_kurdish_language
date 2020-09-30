import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleTheLetterListener extends StatefulWidget {
  Color color;
  RichText richText;
  CircleTheLetterListener(this.color,this.richText);
  @override
  _CircleTheLetterListenerState createState() => _CircleTheLetterListenerState();
}

class _CircleTheLetterListenerState extends State<CircleTheLetterListener> {
  _CircleTheLetterListenerState();
  GlobalKey _paintKey = new GlobalKey();
  Offset _offset;
  @override
  Widget build(BuildContext context) {
    return
      new Listener(
        onPointerDown: (PointerDownEvent event) {
          RenderBox referenceBox = _paintKey.currentContext.findRenderObject();
          Offset offset = referenceBox.globalToLocal(event.position);
          setState(() {
            _offset = offset;
          });
        },
        child: new CustomPaint(
          key: _paintKey,
          painter: new MyCustomPainter(_offset,widget.color),
          child: widget.richText
        ),
    );
  }
}
class MyCustomPainter extends CustomPainter {
  final Offset _offset;
  var color;
  MyCustomPainter(this._offset,this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (_offset == null) return;
    canvas.drawCircle(_offset, 10.0, new Paint()..color = color);
  }

  @override
  bool shouldRepaint(MyCustomPainter other) => other._offset != _offset;
}

