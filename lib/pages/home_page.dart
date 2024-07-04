import 'package:flutter/material.dart';
import 'package:ieltszone/pages/test_entry.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        title: Text(
          '27252 · Abdusalomov Abdurazzoq',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const TestEntryPage())),
                    borderRadius: BorderRadius.circular(4),
                    child: Ink(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.qr_code_rounded,
                        size: 65,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLength: 6,
                          decoration: InputDecoration(
                            counter: const Offstage(),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            isDense: true,
                            isCollapsed: true,
                            border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Theme.of(context).colorScheme.secondary)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Ink(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
