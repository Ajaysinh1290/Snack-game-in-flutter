import 'dart:collection';

import 'package:flutter/material.dart';
import 'utils/utils.dart';

class MyPainter extends CustomPainter {
  Queue<Offset> points;
  Offset eggLocation;

  MyPainter(this.points, this.eggLocation);
  @override
  void paint(Canvas canvas, Size canvasSize) {
    int i=0;
    points.forEach((point) {
      int margin=2;
      final rect = Rect.fromLTRB(
          point.dx.toDouble() + margin/2,
          point.dy.toDouble() + margin/2,
          point.dx + SnackUtils.snackRectSize.toDouble() - margin,
          point.dy + SnackUtils.snackRectSize.toDouble() - margin);
      final paint = Paint()
        ..color = ColorPallette.snackColor
        ..style = PaintingStyle.fill;
      canvas.drawRect(rect, paint);
    });

    // for(double i=0; i<canvasSize.width; i+=20){
    //   final paint=Paint()
    //     ..color=Colors.white
    //     ..style=PaintingStyle.fill;
    //   canvas.drawLine(Offset(i, 0), Offset(i,canvasSize.height), paint);
    // }
    // for(double i=0; i<canvasSize.height; i+=20){
    //   final paint=Paint()
    //     ..color=Colors.white
    //     ..style=PaintingStyle.fill;
    //   canvas.drawLine(Offset(0, i), Offset(canvasSize.width,i), paint);
    // }

    final paint = Paint()
      ..color = ColorPallette.eggColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset(eggLocation.dx + SnackUtils.eggSize + 1,
            eggLocation.dy + SnackUtils.eggSize + 1),
        SnackUtils.eggSize.toDouble(),
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
