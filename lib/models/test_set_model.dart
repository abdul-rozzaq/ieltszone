class TestSet {
  int id;
  List<Test> tests;
  int duration;

  TestSet({
    required this.id,
    required this.tests,
    required this.duration,
  });

  static TestSet fromJson(Map<String, dynamic> json) {
    var testsFromJson = json['tests'] as List;
    List<Test> testList = testsFromJson.map((test) => Test.fromJson(test)).toList();

    return TestSet(
      id: json['id'],
      tests: testList,
      duration: json['duration'],
    );
  }
}

class Test {
  int id;
  String question;
  List<Answer> answers;
  int? answerId;

  Test({required this.id, required this.question, required this.answers, this.answerId});

  static Test fromJson(Map<String, dynamic> json) {
    var answersFromJson = json['answers'] as List;
    List<Answer> answerList = answersFromJson.map((answer) => Answer.fromJson(answer)).toList();

    return Test(
      id: json['id'],
      question: json['question'],
      answers: answerList,
    );
  }

  get selectedAnswer => answers.firstWhere((element) => element.id == answerId);
}

class Answer {
  int id;
  String text;

  Answer({
    required this.id,
    required this.text,
  });

  static Answer fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      text: json['text'],
    );
  }
}
