import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../model/UserModel.dart';

class UserService{
    BehaviorSubject<bool> _isLoggedIn;
    BehaviorSubject<UserModel> _user;
    BehaviorSubject<String> _token;
    
    UserService(){
      _isLoggedIn = new BehaviorSubject<bool>.seeded(false);
      _user = new BehaviorSubject<UserModel>();
      _token = new BehaviorSubject<String>();
    }

    String get token => _token.value;
    bool get isLoggedIn => _isLoggedIn.value;
    Observable<bool> get isloggedIn$  => _isLoggedIn.stream;

    UserModel get user => _user.value;

    void loginUser(UserModel user, String token){
      _user.add(user);
      _token.add(token);
      _isLoggedIn.add(true);
    }

    void logoutUser(){
      _user.drain();
      _token.drain();
      _isLoggedIn.add(false) ;
    }
    
}