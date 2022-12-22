import 'package:flemis/mobile/controller/user_controller.dart';
import 'package:flemis/mobile/my_app_mobile.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/widgets/components/loading/loading.dart';
import 'package:flemis/mobile/utils/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';

import '../../../../models/user.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  String get searchFieldLabel => 'Search';
  @override
  TextStyle? get searchFieldStyle => const TextStyle(
        fontSize: 15,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: const AppBarTheme(
        color: primaryColor,
        elevation: 0,
      ),
      textTheme: const TextTheme(
          headline6: TextStyle(
              color: whiteColor, fontSize: 20, fontWeight: FontWeight.bold)),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: whiteColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        labelStyle: TextStyle(color: whiteColor),
        hoverColor: whiteColor,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: whiteColor),
        ),
      ),
      hintColor: whiteColor,
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    AppNavigator navigator = AppNavigator(context: context);
    var screenSize = MediaQuery.of(context).size;
    //final suggestions = query.isEmpty ? [] : [];
    UserController userController = UserController(context: context);
    Manager manager = context.read<Manager>();
    Future _future = userController.findUsersByUsername(query);
    return Container(
      color: primaryColor,
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(context: context);
          }
          if (snapshot.hasData && snapshot.data != null) {
            List<User> users = snapshot.data;
            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) =>
                  _userItem(users, index, context, navigator, manager),
            );
          }
          return errorWidget(screenSize, snapshot);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    /*  AppNavigator navigator = AppNavigator(context: context);
    var screenSize = MediaQuery.of(context).size;
    //final suggestions = query.isEmpty ? [] : [];
    UserController userController = UserController(context: context);
    Future _future = userController.findUsersByUsername(query);
    Manager manager = context.read<Manager>();
    return Container(
      color: primaryColor,
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading(context: context);
          }

          if (snapshot.hasData && snapshot.data != null) {
            List<User> users = snapshot.data;
            return ListView.builder(
              itemCount: users.length,
              padding: const EdgeInsets.only(top: 20),
              itemBuilder: (context, index) =>
                  _userItem(users, index, context, navigator, manager),
            );
          }
          return errorWidget(screenSize, snapshot);
        },
      ),
    ); */
    return Container(
      color: primaryColor,
    );
  }

  Widget errorWidget(Size screenSize, AsyncSnapshot data) {
    return AnimationConfiguration.staggeredList(
      position: 0,
      child: FadeInAnimation(
        duration: const Duration(seconds: 2),
        curve: Curves.ease,
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 0,
            ),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            child: SizedBox(
              height: screenSize.height * 0.7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      data.error != null ? data.error.toString() : "no data",
                      style: const TextStyle(color: whiteColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userItem(List<User> users, int index, BuildContext context,
      AppNavigator navigator, Manager manager) {
    return InkWell(
      onTap: () => navigator.goToProfile(
          isYourProfile: users[index].id != manager.user!.id,
          user: users[index],
          isAnimated: true),
      child: ListTile(
        leading: users[index].avatarUrl != null &&
                users[index].avatarUrl!.isNotEmpty
            ? CircleAvatar(
                backgroundImage: Image.network(
                  users[index].avatarUrl!,
                  loadingBuilder: (context, child, loadingProgress) => Loading(
                    context: context,
                  ),
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("./assets/avatar.png"),
                  fit: BoxFit.cover,
                ).image,
                radius: 30,
              )
            : CircleAvatar(
                backgroundImage: Image.asset(
                  "./assets/avatar.png",
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("./assets/avatar.png"),
                  fit: BoxFit.cover,
                ).image,
                radius: 30,
              ),
        title: Text(users[index].username!),
      ),
    );
  }
}
