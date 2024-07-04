import 'package:flutter/material.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/main.dart';
import 'package:ieltszone/models/test_set_model.dart';
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

    double width = MediaQuery.of(context).size.width * 0.8 * (provider.timeLeft / provider.testSet.duration);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
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
                          InkWell(
                            onTap: provider.nextTest,
                            child: Ink(
                              padding: const EdgeInsets.all(12),
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.secondary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  'Next',
                                  style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    secondsToTime(provider.timeLeft),
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    width: width,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ],
              ),
            )
          ],
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
