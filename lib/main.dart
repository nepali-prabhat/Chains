import 'package:flutter/material.dart';
import 'package:chains/pages/home.dart';
import 'package:get_it/get_it.dart';
import'package:chains/service/cycleService.dart';
GetIt cycleController = new GetIt();
void main(){
    cycleController.registerSingleton<CycleService>(new CycleService());
    runApp(Chain());
}

class Chain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}
