import 'package:flutter/material.dart';

import '../../res/coolor.dart';

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Coolor.WHITE;
    paint.strokeWidth = 1;
    paint.strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width/2, 260),
      Offset(size.width/2, 55),
      paint,
    );

    

    var path = Path();
    path.close();

    paint.style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}