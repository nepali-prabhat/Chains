import 'dart:math';
import 'package:flutter/material.dart';

import '../colors.dart';

class ClockDialPainter extends CustomPainter{
  
  final minuteTickMarkLength = 10.0;

  final minuteTickMarkWidth = 2.5; 
  final int noOfDials;

  final Paint tickPaint;
  final TextPainter textPainter;

  ClockDialPainter({this.noOfDials})
      :tickPaint= new Paint(),
        textPainter= new TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        )
  {
    tickPaint.color= Colors.black26;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle= 2* pi / noOfDials;
    final radius= size.width/2;
    canvas.save();

    // drawing
    canvas.translate(radius, radius);
    for (var i = 0; i< noOfDials; i++ ) {

      //make the length and stroke of the tick marker longer and thicker depending
      tickMarkLength = minuteTickMarkLength;
      tickPaint.strokeWidth= minuteTickMarkWidth;
        if(i%5 == 0 ){
        canvas.drawLine(
            new Offset(0.0, -radius), new Offset(0.0, -radius+tickMarkLength), tickPaint);
        canvas.rotate(angle*5);
        }
    }

    canvas.restore();

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

