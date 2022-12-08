import 'package:flemis/mobile/controller/account_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/components/loading/loading.dart';

class MobileEditProfileScreen extends StatefulWidget {
  const MobileEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<MobileEditProfileScreen> createState() =>
      _MobileEditProfileScreenState();
}

class _MobileEditProfileScreenState extends State<MobileEditProfileScreen> {
  Manager? manager;
  AccountController? accountController;

  @override
  void initState() {
    accountController = AccountController(context: context);
    manager = context.read<Manager>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Edit profile",
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () async => await accountController?.updateProfile({
              "userId": manager!.user!.id!.toString(),
              "username":
                  accountController?.userNameController?.text.toString(),
              "email": accountController?.newEmailController?.text.toString(),
              "firstname":
                  accountController?.firstNameController?.text.toString(),
              "lastname":
                  accountController?.lastNameController!.text.toString(),
              "bio": accountController?.userBioController?.text.toString(),
              "birthday": accountController?.birthdayController?.text.toString()
            }),
            child: const Text(
              "Done",
              style: TextStyle(
                color: secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      backgroundColor: tertiaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _editAvatar(),
              const SizedBox(),
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Change avatar",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),
                  ),
                ),
              ),
              _updateForms(screenSize),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editAvatar() {
    return Container(
      margin: const EdgeInsets.only(top: 25),
      child: manager?.user?.avatarUrl != null &&
              manager!.user!.avatarUrl!.isNotEmpty
          ? CircleAvatar(
              backgroundImage: Image.network(
                manager!.user!.avatarUrl!,
                loadingBuilder: (context, child, loadingProgress) => Loading(
                  context: context,
                ),
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("./assets/avatar.png"),
                fit: BoxFit.cover,
              ).image,
              radius: 60,
            )
          : CircleAvatar(
              backgroundImage: Image.asset(
                "./assets/avatar.png",
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("./assets/avatar.png"),
                fit: BoxFit.cover,
              ).image,
              radius: 60,
            ),
    );
  }

  Widget _updateForms(Size screenSize) {
    return Column(
      children: [
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15),
                child: Text("Username", style: secondaryFontStyle[2]),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    controller: accountController?.userNameController,
                  ),
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15),
                child: Text("Firstname", style: secondaryFontStyle[2]),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    controller: accountController?.firstNameController,
                  ),
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 15),
                child: Text("Lastname", style: secondaryFontStyle[2]),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    controller: accountController?.lastNameController,
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenSize.width * 0.23,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  "Bio",
                  textAlign: TextAlign.center,
                  style: secondaryFontStyle[2],
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    controller: accountController?.userBioController,
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenSize.width * 0.23,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 20, top: 15),
                child: Text(
                  "Email",
                  textAlign: TextAlign.center,
                  style: secondaryFontStyle[2],
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    controller: accountController?.newEmailController,
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: screenSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: screenSize.width * 0.23,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: Text(
                  "Birthday",
                  textAlign: TextAlign.center,
                  style: secondaryFontStyle[2],
                ),
              ),
              Flexible(
                child: SizedBox(
                  width: screenSize.width * 0.65,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (value) => Validators.isValidDate(value!),
                    decoration: const InputDecoration(
                      hintText: "month/date/year",
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9/]')),
                      FilteringTextInputFormatter.deny(''),
                      FilteringTextInputFormatter.deny(' '),
                      FilteringTextInputFormatter.deny('  '),
                      FilteringTextInputFormatter.deny('//'),
                      FilteringTextInputFormatter.deny('///'),
                      FilteringTextInputFormatter.deny('///'),
                    ],
                    maxLength: 10,
                    controller: accountController?.birthdayController,
                  ),
                ),
              ),
              const SizedBox()
            ],
          ),
        )
      ],
    );
  }
}
