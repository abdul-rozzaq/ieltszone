import 'package:flutter/material.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/main.dart';
import 'package:ieltszone/models/exam_model.dart';
import 'package:provider/provider.dart';

class SolveTest extends StatefulWidget {
  const SolveTest({super.key});

  @override
  State<SolveTest> createState() => _SolveTestState();
}

class _SolveTestState extends State<SolveTest> with WidgetsBindingObserver {
  late AppProvider provider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    provider = Provider.of(context, listen: false);
    provider.startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    provider.stopTest();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    double width = MediaQuery.of(context).size.width * 0.9 * (provider.timeLeft / provider.exam.duration);

    bool previousBtn = provider.currentTestIndex > 0;
    bool finishBtn = provider.process == 1.0;
    bool nextBtn = provider.currentTestIndex < provider.exam.tests.length - 1;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      width: width,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Text(
                      secondsToTime(provider.timeLeft),
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Text(
                            provider.currentTest.question,
                            maxLines: 2,
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Column(
                          children: [
                            const SizedBox(height: 50),
                            ...getAnswers(),
                            const SizedBox(height: 30),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(4),
                                    onTap: provider.previousTest,
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: previousBtn ? Theme.of(context).colorScheme.secondary : null,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Previous',
                                          style: TextStyle(
                                            color: previousBtn ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(4),
                                    onTap: () => finishBtn
                                        ? showDialog(
                                            context: context,
                                            builder: (contex) => AlertDialog(
                                              title: const Text('Are you sure ?'),
                                              actions: [
                                                MaterialButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Cancel'),
                                                ),
                                                MaterialButton(
                                                  onPressed: () => provider.finishTest(),
                                                  textColor: Theme.of(context).colorScheme.secondary,
                                                  color: Theme.of(context).colorScheme.primary,
                                                  child: const Text('Finish'),
                                                )
                                              ],
                                            ),
                                          )
                                        : null,
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: finishBtn ? Theme.of(context).colorScheme.secondary : null,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Finish',
                                          style: TextStyle(
                                            color: finishBtn ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(4),
                                    onTap: provider.nextTest,
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: nextBtn ? Theme.of(context).colorScheme.secondary : null,
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Next',
                                          style: TextStyle(
                                            color: nextBtn ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 52,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.exam.tests.length,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(4),
                        onTap: () => provider.setTestByIndex(index),
                        child: Ink(
                          width: provider.currentTestIndex == index ? 90 : 60,
                          decoration: BoxDecoration(
                            color: provider.exam.tests[index].answerId != null ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(width: 1, color: Theme.of(context).colorScheme.secondary),
                          ),
                          child: Center(
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: provider.exam.tests[index].answerId != null ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Iterable<Widget> getAnswers() {
    AppProvider provider = Provider.of(context, listen: true);

    Widget answerWidget(Answer ans) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          width: double.maxFinite,
          decoration: BoxDecoration(border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 2), borderRadius: BorderRadius.circular(8)),
          child: RadioListTile<int>(
            dense: true,
            title: Text(ans.text, style: TextStyle(color: Theme.of(context).colorScheme.secondary)),
            value: ans.id,
            groupValue: provider.currentTest.answerId,
            fillColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).colorScheme.secondary),
            onChanged: provider.setTestAnswer,
          ),
        );

    return provider.currentTest.answers.map<Widget>((e) => answerWidget(e));
  }
}
