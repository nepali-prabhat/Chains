import 'package:flutter/material.dart';

import 'Cycle/clock.dart';
import 'Cycle/clock_text.dart';

class Cycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: new Padding(
          padding: const EdgeInsets.all(30),
          child: new Clock(noOfDials: 30,),
        ),
      ),
    );
  }
}
