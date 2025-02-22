import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/pages/home_page.dart';
import 'package:ieltszone/pages/register_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await GetStorage.init();
  
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppProvider()),
    ],
    child: const App(),
  ));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    AppProvider provider = Provider.of(context, listen: false);
    provider.loadUser();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    AppProvider provider = Provider.of(context, listen: true);

    return MaterialApp(
      navigatorKey: provider.navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: const Color.fromARGB(255, 63, 9, 68),
          secondary: const Color.fromARGB(255, 236, 255, 8),
        ),
        useMaterial3: true,
      ),
      home: provider.isAuth ? const HomePage() : const RegisterPage(),
    );
  }
}

String secondsToTime(int totalSeconds) {
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  return "${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}";
}
