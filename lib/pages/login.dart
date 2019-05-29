import 'package:chains/model/UserModel.dart';
import 'package:chains/service/userService.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Text("login page lol")),
            RaisedButton(
              onPressed: () {
                  userController.get<UserService>().loginUser(UserModel(
                      id: 1,
                      username: "Prabhat",
                      fName: "prabhat",
                      lName: "pandey",
                      email: "pandeyprabat@gmail.com",
                      createdAt: DateTime.parse("2019-05-29 04:45:24"),
                      updatedAt: DateTime.parse("2019-05-29 04:45:24")),
                  "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiaWF0IjoxNTU5MTIzNTE0fQ.9EUtKG133fbSlnb8yZOD_tBF0Wh83XxJ7vVfPbozd7s");
              },
              child: Text("login lol"),
            )
          ],
        ),
      ),
    ));
  }
}
