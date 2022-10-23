import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/ui/screens/login/mobile_login_screen.dart';
import 'package:flemis/mobile/ui/screens/register/mobile_register.dart';
import 'package:flutter/material.dart';

class MobileIntroScreen extends StatefulWidget {
  const MobileIntroScreen({Key? key}) : super(key: key);

  @override
  State<MobileIntroScreen> createState() => _MobileIntroScreenState();
}

class _MobileIntroScreenState extends State<MobileIntroScreen> {
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  bool visiblePassword = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: screenSize.height < 700
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: transparentColor,
            ),
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenSize.height * 0.12,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Flemis",
                      style: primaryFontStyle[0],
                    ),
                    SizedBox(
                      height: screenSize.height * 0.08,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Text(
                        "Welcome to flemis!\n If you don't have account, please create new account to use our services.",
                        style: secondaryFontStyle[2],
                        textAlign: TextAlign.center,
                        softWrap: true,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: screenSize.width * 0.85,
                    margin: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: secondaryColor,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MobileLoginScreen(),
                        ),
                      ),
                      child: Text(
                        "Login",
                        style: primaryFontStyle[6],
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: screenSize.width * 0.85,
                    margin: const EdgeInsets.only(top: 30),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                            color: secondaryColor,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MobileRegister(),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: primaryFontStyle[6],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
