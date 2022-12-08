import 'package:flemis/mobile/controller/auth_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  bool visiblePassword = false;
  AuthController? authController;
  AppNavigator? navigator;
  @override
  void initState() {
    navigator = AppNavigator(context: context);
    authController = AuthController(context: context);
    super.initState();
  }

  @override
  void dispose() {
    authController?.userNameController.dispose();
    authController?.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        extendBodyBehindAppBar: screenSize.height < 750 ? true : false,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: transparentColor,
          automaticallyImplyLeading: false,
        ),
        backgroundColor: primaryColor,
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: SingleChildScrollView(
            padding: screenSize.height < 700
                ? const EdgeInsets.only(top: 15)
                : screenSize.height < 750
                    ? const EdgeInsets.only(top: 45)
                    : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Text(
                    "Flemis",
                    style: screenSize.height < 700
                        ? primaryFontStyle[1]
                        : primaryFontStyle[0],
                  ),
                ),
                SizedBox(
                  height: screenSize.height < 700
                      ? screenSize.height * 0.04
                      : screenSize.height < 800
                          ? screenSize.height * 0.05
                          : screenSize.height * 0.1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        "Username",
                        style: primaryFontStyle[6],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: screenSize.width * 0.85,
                      child: TextFormField(
                        controller: authController?.userNameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.only(bottom: 10, left: 20),
                          filled: true,
                          fillColor: const Color(0xffB7BDF7),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 1,
                              color: secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                //  color: Theme.of(context).colorScheme.surface,
                                ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Text(
                        "Password",
                        style: primaryFontStyle[6],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5),
                      height: 50,
                      width: screenSize.width * 0.85,
                      child: TextFormField(
                        controller: authController?.passwordController,
                        textAlignVertical: TextAlignVertical.center,
                        autofocus: false,
                        obscureText: !visiblePassword,
                        decoration: InputDecoration(
                          suffixIconColor: secondaryColor,
                          suffixIcon: IconButton(
                            icon: Icon(
                              !visiblePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color:
                                  visiblePassword ? secondaryColor : whiteColor,
                              size: 20,
                            ),
                            onPressed: () {
                              if (!visiblePassword) {
                                setState(() {
                                  visiblePassword = true;
                                });
                              } else {
                                setState(() {
                                  visiblePassword = false;
                                });
                              }
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.only(bottom: 10, left: 20),
                          filled: true,
                          fillColor: const Color(0xffB7BDF7),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 0.5,
                              color: secondaryColor,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                //color: Theme.of(context).colorScheme.surface,
                                ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 70,
                  width: screenSize.width * 0.85,
                  margin: const EdgeInsets.only(top: 40),
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
                    onPressed: () async {
                      authController?.login(
                          authController!.userNameController.text,
                          authController!.passwordController.text);
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Text(
                      "Login",
                      style: primaryFontStyle[6],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: TextButton(
                    child: Text(
                      "Forgot password?",
                      style: primaryFontStyle[7],
                      softWrap: true,
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {},
                  ),
                ),
                //style: secondaryFontStyle[2],
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                      text: "Don't have account? ",
                      style: secondaryFontStyle[2],
                      children: [
                        TextSpan(
                          text: " Register",
                          style: primaryFontStyle[8],
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => navigator?.goToRegister(),
                        ),
                      ],
                    ),
                  ),
                ),
                /*SizedBox(
                  height: screenSize.height < 700 ? 90 : 100,
                  width: screenSize.width,
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Divider(
                          color: whiteColor,
                          endIndent: 10,
                        ),
                      ),
                      Text(
                        "Or \n with",
                        style: primaryFontStyle[7],
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                      const Expanded(
                          child: Divider(
                        color: whiteColor,
                        indent: 10,
                      )),
                    ],
                  ),
                ),
                Container(
                  padding: screenSize.height < 700
                      ? const EdgeInsets.only(bottom: 20)
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(25),
                        ),
                      ),
                    ],
                  ),
                )*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
