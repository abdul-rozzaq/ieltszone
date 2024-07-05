import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:ieltszone/app_provider.dart';
import 'package:ieltszone/models/user_model.dart';
import 'package:ieltszone/pages/home_page.dart';
import 'package:ieltszone/services/storage_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscured = true;

  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        color: Theme.of(context).colorScheme.secondary,
                        height: 130,
                      ),
                      const SizedBox(height: 30),
                      Text(
                        'IELTS Zone',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextField(
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        maxLength: 5,
                        controller: idController,
                        maxLengthEnforcement: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          isDense: true,
                          counter: const Offstage(),
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                          labelText: 'ID',
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: passwordController,
                        cursorColor: Theme.of(context).colorScheme.secondary,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          isDense: true,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                          labelText: 'Password',
                          contentPadding: const EdgeInsets.all(12),
                          suffixIcon: InkWell(
                            splashColor: Colors.transparent,
                            splashFactory: NoSplash.splashFactory,
                            onTap: () => setState(() => obscured = !obscured),
                            child: Icon(
                              obscured ? CupertinoIcons.eye_solid : CupertinoIcons.eye_slash_fill,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                        obscureText: obscured,
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: login,
                        child: Ink(
                          padding: const EdgeInsets.all(12),
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        color: Theme.of(context).colorScheme.secondary,
                        height: 30,
                        thickness: 1.5,
                        indent: 20,
                        endIndent: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text(
                              'Register',
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  'V 1.0',
                  style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(fontFamily: GoogleFonts.poppins().fontFamily, fontWeight: FontWeight.bold),
                    children: const [
                      TextSpan(text: 'by '),
                      TextSpan(text: 'Abdurazzoq'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() async {
    if (idController.text.trim() != "" && passwordController.text.trim() != "") {
      FocusScope.of(context).unfocus();

      showDialog(
        context: context,
        builder: (context) => Center(
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );

      AppProvider provider = Provider.of(context, listen: false);

      Response response = await provider.login(int.parse(idController.text.trim()), passwordController.text.trim());

      if (response.statusCode == 200) {
        User user = User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));

        await UserStorage().saveUser(user);

        provider.user = user;
        provider.isAuth = true;

        return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (x) => false);
      }

      Navigator.of(context).pop();
    }
  }
}
