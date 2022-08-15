import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MobileRegister extends StatefulWidget {
  const MobileRegister({Key? key}) : super(key: key);

  @override
  State<MobileRegister> createState() => _MobileRegisterState();
}

class _MobileRegisterState extends State<MobileRegister> {
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
                height: screenSize.height * 0.07,
              ),
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
                margin: const EdgeInsets.only(top: 70),
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
                height: 70,
                width: screenSize.width * 0.85,
                margin: const EdgeInsets.only(top: 30),
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
                    "Register",
                    style: primaryFontStyle[6],
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
