import 'package:flutter/material.dart';
import 'package:chains/home.dart';

void main() => runApp(Chain());

class Chain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}
