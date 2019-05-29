import 'package:chains/main.dart';
import 'package:chains/model/UserModel.dart';
import 'package:chains/service/userService.dart';
import 'package:flutter/material.dart';

class Stats extends StatelessWidget {
  final _userController = userController.get<UserService>();
  @override
  Widget build(BuildContext context) {
    UserModel user = _userController.user;
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                    child: Text(
                        "${user.id}:${user.fName} ${user.lName} is logged in :)")),
                RaisedButton(
                    onPressed: (){
                        _userController.logoutUser();
                    },
                    child: Text("log out."),
                )
              ],
            )));
  }
}
