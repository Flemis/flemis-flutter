import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  ValueNotifier<String> policy = ValueNotifier<String>("");
  Future<String> loadPolicies() async {
    return await rootBundle
        .loadString("./assets/policies/privacy_policy_english.txt");
  }

  @override
  void didChangeDependencies() async {
    policy.value = await loadPolicies().catchError((error, stack) {
      return error;
    }).then((value) {
      return value;
    }, onError: (error) {
      return error;
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Privacy Policy",
          style: primaryFontStyle[7],
        ),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: false,
      backgroundColor: primaryColor,
      body: SizedBox(
        height: screenSize.height,
        width: screenSize.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              ValueListenableBuilder<String>(
                valueListenable: policy,
                builder: (context, data, _) {
                  return Text(
                    data,
                    style: secondaryFontStyle[9],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
