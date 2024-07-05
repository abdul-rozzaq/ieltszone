import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () async => await startExam(await scan()),
            borderRadius: BorderRadius.circular(4),
            child: Ink(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                Icons.qr_code_rounded,
                size: 65,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextField(
                  controller: codeController,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  maxLength: 6,
                  cursorColor: Theme.of(context).colorScheme.secondary,
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
              InkWell(
                onTap: () async => codeController.text.trim() != '' ? startExam(codeController.text.trim()) : null,
                child: Ink(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  scan() async {
    ScanResult result = await BarcodeScanner.scan();

    return result.rawContent;
  }

  startExam(String code) async {
    Provider.of<AppProvider>(context, listen: false).fetchExam(code);
  }
}
