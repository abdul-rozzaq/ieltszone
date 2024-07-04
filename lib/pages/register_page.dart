import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ieltszone/pages/home_page.dart';
import 'package:ieltszone/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 2, color: Theme.of(context).colorScheme.secondary)),
                          isDense: true,
                          labelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.w700,
                          ),
                          labelText: 'Full name',
                          contentPadding: const EdgeInsets.all(12),
                        ),
                        style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () => Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (x) => false),
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
                            'Already have an account?',
                            style: TextStyle(color: Theme.of(context).colorScheme.secondary, fontSize: 12),
                          ),
                          const SizedBox(width: 4),
                          InkWell(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage())),
                            child: Text(
                              'Login',
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
}
