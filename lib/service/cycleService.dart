import 'dart:convert';

import 'package:chains/service/userService.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chains/main.dart';

class CycleService {
  Timer _timer;
  BehaviorSubject<int> _duration;
  int _cycleId; 
  BehaviorSubject<DateTime> _startTime;
  BehaviorSubject<bool> _isCycling = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<int> _elapsedTime;

  CycleService() {
    _duration = BehaviorSubject<int>.seeded(1);
    _isCycling = BehaviorSubject<bool>.seeded(false);
    _elapsedTime = BehaviorSubject<int>.seeded(0);
    _startTime =
        BehaviorSubject<DateTime>.seeded(DateTime.utc(1969, 7, 20, 20, 18, 04));
  }

  Observable<bool> get isCycling$ => _isCycling.stream;
  bool get isCycling => _isCycling.value;

  Observable<int> get duration$ => _duration.stream;
  int get duration => _duration.value;

  Observable<DateTime> get startTime$ => _startTime.stream;
  DateTime get startTime => _startTime.value;

  Observable<int> get elapsedTime$ => _elapsedTime.stream;
  int get elapsedTime => _elapsedTime.value;

  void startCycle() {
    if (!isCycling) {
      _startTime.add(DateTime.now());
      _isCycling.add(true);
      _timer = new Timer.periodic(Duration(seconds: 1), _increaseTime);
      var body = {
        "token": userController.get<UserService>().token,
        "date_time": startTime.toString(),
        "duration": duration.toString()
      };
      http
          .post('http://192.168.1.70:3000/chains/make', body: body)
          .then((response) {
                print(response.body);
                _cycleId = jsonDecode(response.body)['id'];
                //print(_cycleId);

      });
    }
  }

  void increaseDuration() {
    if (!isCycling) {
      if (duration <= 30) {
        _duration.add(duration + 5);
      }
    }
  }

  void decreaseDuration() {
    if (!isCycling) {
      if (duration >=1) {
        _duration.add(duration - 5);
      }
    }
  }

  void endCycle() {
    if (isCycling) {
      _timer.cancel();
      _isCycling.add(false);
      _duration.add(15);
      _elapsedTime.add(0);
    }
  }

  void _increaseTime(Timer timer) {
    if (isCycling) {
      if (elapsedTime / 60 < duration) {
        _elapsedTime.add(elapsedTime + 1);
      } else {
        endCycle();
        var body = {
          "token": userController.get<UserService>().token,
        };
        http
            .put('http://192.168.1.70:3000/chains/complete/$_cycleId', body: body)
            .then((response) {
                print(response.body);
        });
      }
    }
  }

  void dispose() {
    _duration.close();
    _startTime.close();
    _isCycling.close();
    _elapsedTime.close();
  }
}
