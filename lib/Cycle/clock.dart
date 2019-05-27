import 'package:chains/colors.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'clock_dial_painter.dart';
import 'clock_hands.dart';
import 'clock_face.dart';

typedef TimeProducer = DateTime Function();

class Clock extends StatefulWidget {
  final TimeProducer getCurrentTime;
  final Duration updateDuration;
  final int noOfDials;
  Clock(
      {this.getCurrentTime = getSystemTime,
      this.updateDuration = const Duration(seconds: 1),
      @required this.noOfDials});

  static DateTime getSystemTime() {
    return new DateTime.now();
  }

  @override
  State<StatefulWidget> createState() {
    return _Clock();
  }
}

class _Clock extends State<Clock> {
  Timer _timer;
  DateTime dateTime;
  @override
  void initState() {
    super.initState();
    dateTime = new DateTime.now();
    this._timer = new Timer.periodic(widget.updateDuration, setTime);
  }

  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: 1.0,
      child: buildClockCircle(context),
    );
  }

  Container buildClockCircle(BuildContext context) {
    return new Container(
        width: double.infinity,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          boxShadow: [
            new BoxShadow(
              offset: new Offset(0.0, 0),
              color: shadowColor,
              blurRadius: 1.0,
            ),
            new BoxShadow(
              offset: new Offset(0.0, 0),
              color: circleColor,
              spreadRadius: -15,
              blurRadius: 10.0,
            )
          ],
        ),
        child: Stack(
          children: <Widget>[
            ClockFace(dateTime: dateTime, noOfDials: widget.noOfDials),
            Container(
              padding: EdgeInsets.all(25),
              width: double.infinity,
              child: CustomPaint(
                painter: ClockDialPainter(noOfDials: widget.noOfDials),
              ),
            ),
            ClockHands(dateTime: dateTime, noOfDials: widget.noOfDials),
          ],
        ));
  }
}
