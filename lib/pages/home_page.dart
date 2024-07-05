import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ieltszone/tabs/account_tab.dart';
import 'package:ieltszone/tabs/home_tab.dart';
import 'package:ieltszone/tabs/statistics_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).colorScheme.primary,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_rounded), label: 'Test'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Statistic'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_crop_circle_fill), label: 'Account'),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        showUnselectedLabels: false,
        unselectedItemColor: const Color.fromARGB(255, 158, 168, 57),
        onTap: (int? index) => setState(() => tabIndex = index!),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo.png',
              color: Theme.of(context).colorScheme.secondary,
              height: 50,
            ),
            const SizedBox(width: 10),
            Text('IELTS ZONE', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: IndexedStack(
        index: tabIndex,
        children: const [
          HomeTab(),
          StatisticsTab(),
          AccountTab(),
        ],
      ),
    );
  }
}
