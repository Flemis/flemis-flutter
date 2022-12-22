import 'dart:io';

import 'package:flemis/mobile/controller/auth_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;

class MobileRegisterSecondPage extends StatefulWidget {
  const MobileRegisterSecondPage({Key? key, this.avatar, this.authController})
      : super(key: key);
  final File? avatar;
  final AuthController? authController;
  @override
  State<MobileRegisterSecondPage> createState() =>
      _MobileRegisterSecondPageState();
}

class _MobileRegisterSecondPageState extends State<MobileRegisterSecondPage> {
  AuthController? authController;
  AppNavigator? appNavigator;
  ValueNotifier<bool> isTermsChecked = ValueNotifier<bool>(false);

  @override
  void initState() {
    authController = AuthController(context: context);
    authController?.userNameController =
        widget.authController!.userNameController;
    authController?.emailController = widget.authController!.emailController;
    appNavigator = AppNavigator(context: context);
    super.initState();
  }

  bool visiblePassword = false;
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
      ),
      backgroundColor: primaryColor,
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: screenSize.height < 750
                    ? screenSize.height * 0.05
                    : screenSize.height * 0.07,
              ),
              SizedBox(
                child: Column(
                  children: [
                    Text(
                      "Flemis",
                      style: screenSize.height < 750
                          ? primaryFontStyle[1]
                          : primaryFontStyle[0],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: screenSize.height < 700
                    ? screenSize.height * 0.05
                    : screenSize.height * 0.1,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Text(
                      "First name",
                      style: primaryFontStyle[6],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 50,
                    width: screenSize.width * 0.85,
                    child: TextFormField(
                      controller: authController?.firstNameController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(''),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('  '),
                      ],
                      decoration: InputDecoration(
                        hintText: "First name",
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
                            width: 0.5,
                            //color: Theme.of(context).colorScheme.surface,
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
                      "Last name",
                      style: primaryFontStyle[6],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 50,
                    width: screenSize.width * 0.85,
                    child: TextFormField(
                      controller: authController?.lastNameController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(''),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('  '),
                      ],
                      decoration: InputDecoration(
                        hintText: "Last name",
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
                            width: 0.5,
                            //color: Theme.of(context).colorScheme.surface,
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
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !visiblePassword,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        suffixIconColor: secondaryColor,
                        suffixIcon: IconButton(
                          icon: Icon(
                            !visiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: visiblePassword ? secondaryColor : null,
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
                        hintText: "Password",
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
                            width: 1,
                            //  color: secondaryColor,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: isTermsChecked,
                        builder: (context, checked, _) {
                          return Checkbox(
                            activeColor: secondaryColor,
                            checkColor: primaryColor,
                            value: checked,
                            onChanged: (value) {
                              isTermsChecked.value = value!;
                            },
                          );
                        }),
                    RichText(
                      text: TextSpan(
                        text: "",
                        style: secondaryFontStyle[2],
                        children: [
                          TextSpan(
                            text: "Terms of service",
                            style: primaryFontStyle[8],
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => appNavigator?.goToPrivacyScreen(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: screenSize.height < 700 ? 50 : 70,
                width: screenSize.width * 0.85,
                margin: EdgeInsets.only(top: screenSize.height < 700 ? 25 : 50),
                child: ValueListenableBuilder<bool>(
                    valueListenable: isTermsChecked,
                    builder: (context, checked, _) {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: !checked ? Colors.grey : secondaryColor,
                            ),
                          ),
                        ),
                        onPressed: !checked
                            ? null
                            : () async => await authController?.register(
                                    file: widget.avatar != null
                                        ? {
                                            "fileName": path
                                                .basename(widget.avatar!.path),
                                            "bytes": widget.avatar
                                                ?.readAsBytesSync()
                                                .buffer
                                                .asUint8List()
                                          }
                                        : null,
                                    {
                                      "username": authController
                                          ?.userNameController.text,
                                      "email":
                                          authController?.emailController.text,
                                      "firstname": authController
                                          ?.firstNameController.text,
                                      "lastname": authController
                                          ?.lastNameController.text,
                                      "password": authController
                                          ?.passwordController.text
                                    }),
                        child: Text(
                          "Register",
                          style: !checked
                              ? disableButtonStyle
                              : primaryFontStyle[6],
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
