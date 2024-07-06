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
// const String url = 'https://ieltszone.pythonanywhere.com';

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
    if (currentTestIndex < exam.tests.length - 1) {
      currentTestIndex += 1;
      notifyListeners();
    }
  }

  void previousTest() {
    if (currentTestIndex > 0) {
      currentTestIndex -= 1;
      notifyListeners();
    }
  }

  void finishTest() async {
    navigatorKey.currentState!.pop();

    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
        ),
      ),
    );

    Map data = {
      'exam': exam.id.toString(),
      'answers': exam.tests
          .map((e) => {
                "test": e.id.toString(),
                "answer": e.answerId.toString(),
              })
          .toList(),
    };

    User user = UserStorage().getUser()!;

    Response response = await post(Uri.parse('$url/api/answer-sheet/'), body: jsonEncode(data), headers: {'Authorization': 'Token ${user.token}', 'Content-Type': 'application/json; charset=utf-8'});

    navigatorKey.currentState!.pop();

    if (response.statusCode == 201) {
      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const ResultPage()));
    }
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

  fetchExam(String code) async {
    if (code.trim() != '') {
      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: Theme.of(navigatorKey.currentContext!).colorScheme.secondary,
          ),
        ),
      );

      Response response = await get(Uri.parse('$url/api/exams/by-code/$code/'));

      if (response.statusCode == 200) {
        Exam exam = Exam.fromJson(jsonDecode(response.body));

        this.exam = exam;
        currentTestIndex = 0;

        notifyListeners();

        navigatorKey.currentState!.pop();
        return navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => const TestEntryPage()));
      }

      navigatorKey.currentState!.pop();
    }
  }

  void setTestByIndex(int index) {
    if (index >= 0 && index <= exam.tests.length - 1) {
      currentTestIndex = index;

      notifyListeners();
    }
  }
}
