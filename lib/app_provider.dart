import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ieltszone/models/exam_model.dart';
import 'package:ieltszone/models/user_model.dart';
import 'package:ieltszone/pages/test_entry.dart';
import 'package:ieltszone/pages/test_result.dart';
import 'package:ieltszone/services/storage_service.dart';

const String url = 'http://192.168.93.65:8000';

class AppProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late Timer timer;
  late Exam exam;
  late User user;

  bool isAuth = false;

  int timeLeft = 0;
  int currentTestIndex = 0;

  Test get currentTest => exam.tests[currentTestIndex];
  double get process => exam.tests.where((element) => element.answerId != null).length / exam.tests.length;

  void startTimer() {
    timeLeft = exam.duration;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
      } else {
        navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const ResultPage()));
        timer.cancel();

        stopTest();
      }
      notifyListeners();
    });
  }

  void stopTest() {}

  void setTestAnswer(int? id) {
    currentTest.answerId = id;

    notifyListeners();
  }

  void nextTest() {
    currentTestIndex++;

    if (currentTestIndex >= exam.tests.length) {
      currentTestIndex = 0;

      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const ResultPage()));
      timer.cancel();
    }

    notifyListeners();
  }

  void loadUser() {
    User? user = UserStorage().getUser();

    if (user != null) {
      this.user = user;
      isAuth = true;
    }
  }

  register(String fullName) async => await post(Uri.parse('$url/api/register/'), body: {'full_name': fullName});

  login(int id, String password) async => await post(Uri.parse('$url/api/login/'), body: {'id': id.toString(), 'password': password});

  void fetchExam(String code) async {
    if (code.trim() != '') {
      Response response = await get(Uri.parse('$url/api/exams/by-code/$code/'));

      if (response.statusCode == 200) {
        Exam exam = Exam.fromJson(jsonDecode(response.body));

        this.exam = exam;

        notifyListeners();

        navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => const TestEntryPage()));
      }
    }
  }
}
