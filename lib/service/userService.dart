import 'package:rxdart/rxdart.dart';
import '../model/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  BehaviorSubject<bool> _isLoggedIn;
  BehaviorSubject<UserModel> _user;
  BehaviorSubject<String> _token;

  UserService() {
    _isLoggedIn = new BehaviorSubject<bool>.seeded(false);
    _user = new BehaviorSubject<UserModel>();
    _token = new BehaviorSubject<String>();
    SharedPreferences.getInstance().then((pref) {
      if (pref.containsKey("loggedIn")) {
        bool loggedStatus = pref.getBool('loggedIn');
        String storedUser = pref.getString('user');
        String storedToken = pref.getString('token');
        _isLoggedIn.add(loggedStatus);
        _user.add(UserModel.fromJson(storedUser));
        _token.add(storedToken);
      }
    });
  }

  String get token => _token.value;
  bool get isLoggedIn => _isLoggedIn.value;
  Observable<bool> get isloggedIn$ => _isLoggedIn.stream;

  UserModel get user => _user.value;

  void loginUser(UserModel user, String token) {
    _user.add(user);
    _token.add(token);
    _isLoggedIn.add(true);
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.setBool("loggedIn", true);
      prefs.setString("user", user.toJson());
      prefs.setString("token", token);
    });
  }

  void logoutUser() {
    _user.drain();
    _token.drain();
    _isLoggedIn.add(false);
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.remove("loggedIn");
      prefs.remove("user");
      prefs.remove("token");
    });
  }
}
