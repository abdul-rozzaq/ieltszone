import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ieltszone/models/test_set_model.dart';
import 'package:ieltszone/pages/test_result.dart';

class AppProvider extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  late Timer timer;
  late TestSet testSet;

  int timeLeft = 0;
  int currentTestIndex = 0;

  Test get currentTest => testSet.tests[currentTestIndex];

  void startTimer() {
    timeLeft = testSet.duration;

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

  void loadTestSet() async {
    testSet = TestSet.fromJson(jsonDecode(jsonData));
  }

  void setTestAnswer(int? id) {
    currentTest.answerId = id;

    notifyListeners();
  }

  void nextTest() {
    currentTestIndex++;

    if (currentTestIndex >= testSet.tests.length) {
      currentTestIndex = 0;

      navigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: (context) => const ResultPage()));
      timer.cancel();
    }

    notifyListeners();
  }
}

String jsonData = '''
{
  "id": 1,
  "tests": [
    {
      "id": 1,
      "question": "What is the capital of France?",
      "answers": [
        {
          "id": 1,
          "text": "Paris"
        },
        {
          "id": 2,
          "text": "London"
        },
        {
          "id": 3,
          "text": "Berlin"
        },
        {
          "id": 4,
          "text": "Madrid"
        }
      ]
    },
    {
      "id": 2,
      "question": "What is 2 + 2?",
      "answers": [
        {
          "id": 1,
          "text": "3"
        },
        {
          "id": 2,
          "text": "4"
        },
        {
          "id": 3,
          "text": "5"
        },
        {
          "id": 4,
          "text": "6"
        }
      ]
    }
  ],
  "duration": 15
}
''';
