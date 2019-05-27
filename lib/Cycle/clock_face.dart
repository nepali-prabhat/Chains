import 'package:chains/colors.dart';
import 'package:flutter/material.dart';
import 'clock_dial_painter.dart';

class ClockFace extends StatelessWidget {
  final DateTime dateTime;
  final int noOfDials;
  ClockFace({this.dateTime, this.noOfDials});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Padding(
        padding: const EdgeInsets.all(10.0),
        child: new AspectRatio(
          aspectRatio: 0.75,
          child: new Container(
            width: double.infinity,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: faceColor,
            ),
          ),
        ),
      ),
    );
  }
}
