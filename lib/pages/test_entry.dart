import 'package:flutter/material.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/main.dart';
import 'package:ieltszone/pages/solve_test.dart';
import 'package:provider/provider.dart';

class TestEntryPage extends StatefulWidget {
  const TestEntryPage({super.key});

  @override
  State<TestEntryPage> createState() => _TestEntryPageState();
}

class _TestEntryPageState extends State<TestEntryPage> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                provider.exam.title,
                maxLines: 2,
                style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 20, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Ink(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Text(
                      secondsToTime(provider.exam.duration),
                      style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () => nextPage(),
                child: Ink(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  nextPage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const SolveTest()));
  }
}
