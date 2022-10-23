import 'package:flemis/mobile/controller/auth_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileRegister extends StatefulWidget {
  const MobileRegister({Key? key}) : super(key: key);

  @override
  State<MobileRegister> createState() => _MobileRegisterState();
}

class _MobileRegisterState extends State<MobileRegister> {
  AuthController? authController;

  @override
  void initState() {
    authController = AuthController(context: context);
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
                    ? screenSize.height * 0.02
                    : screenSize.height * 0.05,
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
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(''),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('  '),
                        FilteringTextInputFormatter.allow(
                          RegExp("[a-z A-Z 0-9]"),
                        ),
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.text_fields,
                          size: 20,
                        ),
                        hintText: "Username",
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
                      "Email",
                      style: primaryFontStyle[6],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 50,
                    width: screenSize.width * 0.85,
                    child: TextFormField(
                      controller: authController?.emailController,
                      keyboardType: TextInputType.emailAddress,
                      textAlignVertical: TextAlignVertical.center,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(''),
                        FilteringTextInputFormatter.deny(' '),
                        FilteringTextInputFormatter.deny('  '),
                      ],
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.alternate_email,
                          size: 20,
                        ),
                        hintText: "Email",
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
              Container(
                height: screenSize.height < 700 ? 50 : 70,
                width: screenSize.width * 0.85,
                margin: EdgeInsets.only(top: screenSize.height < 700 ? 25 : 50),
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
                  onPressed: () async => await authController?.register({
                    "username": authController?.userNameController.text,
                    "email": authController?.emailController.text,
                    "firstname": authController?.firstNameController.text,
                    "lastname": authController?.lastNameController.text,
                    "password": authController?.passwordController.text
                  }),
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
