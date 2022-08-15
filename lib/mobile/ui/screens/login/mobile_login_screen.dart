import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({Key? key}) : super(key: key);

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  TextEditingController userNameController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: transparentColor,
      ),
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Text(
                  "Logo",
                  style: primaryFontStyle[0],
                ),
              ),
              SizedBox(
                height: screenSize.height * 0.1,
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
                      controller: userNameController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 20),
                        filled: true,
                        fillColor: const Color(0xffB7BDF7),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              //color: Theme.of(context).colorScheme.surface,
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
                      controller: passwordController,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 20),
                        filled: true,
                        fillColor: const Color(0xffB7BDF7),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            width: 0.5,
                            //color: Theme.of(context).colorScheme.surface,
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
                    primary: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  onPressed: () {},
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
                    "Forgot password ?",
                    style: primaryFontStyle[7],
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(
                height: 100,
                width: screenSize.width,
                child: Row(
                  children: <Widget>[
                    const Expanded(
                        child: Divider(
                      color: whiteColor,
                      endIndent: 10,
                    )),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: null,
                    style: ElevatedButton.styleFrom(
                      primary: whiteColor,
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(25),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
