import 'package:flutter/material.dart';
import 'package:chains/pages/login.dart';
import 'package:chains/pages/home.dart';
import 'package:get_it/get_it.dart';
import 'package:chains/service/cycleService.dart';
import 'package:chains/service/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';


GetIt cycleController = new GetIt();
GetIt userController = new GetIt();
void main() {
  cycleController.registerSingleton<CycleService>(new CycleService());
  userController.registerSingleton(new UserService());
  runApp(Chain());
}

class Chain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyPageSelector(),
    );
  }
}

class MyPageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: userController.get<UserService>().isloggedIn$,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(backgroundColor: Colors.white, body: SizedBox());
          } else {
            if (snapshot.data == true) {
              return Home();
            }else{
                return Login();
            }
          }
        });
  }
}
