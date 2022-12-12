import 'package:device_preview/device_preview.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flemis/mobile/providers/manager.dart';
import 'package:flemis/mobile/ui/screens/Base/mobile_base.dart';
import 'package:flemis/mobile/ui/screens/chat/message/message_screen.dart';
import 'package:flemis/mobile/ui/screens/home/mobile_home.dart';
import 'package:flemis/mobile/ui/screens/login/mobile_login_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen.dart';
import 'package:flemis/mobile/ui/screens/post/create/create_post_screen_forms.dart';
import 'package:flemis/mobile/ui/screens/profile/edit/mobile_edit_profile_screen.dart';
import 'package:flemis/mobile/ui/screens/profile/profile_screen.dart';
import 'package:flemis/mobile/ui/screens/register/mobile_register.dart';
import 'package:flemis/mobile/ui/screens/settings/settings_screen.dart';
import 'package:flemis/mobile/ui/screens/splash/splash_screen.dart';
import 'package:flemis/mobile/ui/screens/story/create/create_story_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

const ColorScheme schemeDefault = ColorScheme(
  //old blue
  //primary: const Color(0xff071de8).withOpacity(0.44),
  primary: Color(0xff010773),
  background: Color(0xff010773),
  brightness: Brightness.dark,
  error: Colors.red,
  onBackground: Color(0xff010773),
  onError: Colors.red,
  onPrimary: Color(0xff010773),
  onSecondary: Color(0xfffffc00),
  onSurface: Colors.transparent,
  secondary: Color(0xfffffc00),
  surface: Colors.white,
  tertiary: Colors.black,
);

final ThemeData defaultTheme = ThemeData(
  colorScheme: schemeDefault,
  bottomAppBarColor: schemeDefault.primary,
  primaryTextTheme: GoogleFonts.mochiyPopOneTextTheme(
    const TextTheme(
      headline2: TextStyle(
        color: secondaryColor,
        fontSize: 50,
      ),
      headline3: TextStyle(
        color: secondaryColor,
        fontSize: 40,
      ),
      headline4: TextStyle(
        color: secondaryColor,
        fontSize: 30,
      ),
      headline5: TextStyle(
        color: secondaryColor,
        fontSize: 28,
      ),
      headline6: TextStyle(
        color: whiteColor,
        fontSize: 20,
      ),
      subtitle1: TextStyle(
        color: secondaryColor,
        fontSize: 18,
      ),
      subtitle2: TextStyle(
        color: whiteColor,
        fontSize: 15,
      ),
    ),
  ),
  textTheme: GoogleFonts.interTextTheme(
    const TextTheme(
      headline1: TextStyle(
        color: tertiaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline2: TextStyle(
        color: tertiaryColor,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: TextStyle(
        color: whiteColor,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      bodyText2: TextStyle(
        color: whiteColor,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
    ),
  ),
  useMaterial3: true,
);
final darkTheme = ThemeData(
  primaryTextTheme: GoogleFonts.mochiyPopOneTextTheme(
    const TextTheme(
      headlineLarge: TextStyle(
        color: secondaryColor,
        fontSize: 50,
      ),
    ),
  ),
  primaryColorDark: Colors.black,
  backgroundColor: Colors.black,
);
const primaryColor = Colors.black ?? Color(0xff010773);
const secondaryColor = Color(0xfffffc00);
const tertiaryColor = Colors.black;
const darkColor = Colors.black;
const whiteColor = Colors.white;
const transparentColor = Colors.transparent;

List<TextStyle> primaryFontStyle = <TextStyle>[
  TextStyle(
      color: secondaryColor,
      fontSize: 50,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: secondaryColor,
      fontSize: 40,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: secondaryColor,
      fontSize: 25,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: secondaryColor,
      fontSize: 28,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: whiteColor,
      fontSize: 20,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: primaryColor,
      fontSize: 20,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: secondaryColor,
      fontSize: 18,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: whiteColor,
      fontSize: 15,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
  TextStyle(
      color: secondaryColor,
      fontSize: 13,
      fontFamily: GoogleFonts.mochiyPopOne().fontFamily),
];

List<TextStyle> secondaryFontStyle = <TextStyle>[
  TextStyle(
      color: tertiaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.inter().fontFamily),
  TextStyle(
      color: tertiaryColor,
      fontSize: 15,
      fontWeight: FontWeight.w700,
      fontFamily: GoogleFonts.inter().fontFamily),
  TextStyle(
      color: whiteColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.inter().fontFamily),
  TextStyle(
    color: whiteColor,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
  TextStyle(
    color: whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
  TextStyle(
    color: primaryColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
  TextStyle(
    color: tertiaryColor,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
  TextStyle(
    color: tertiaryColor,
    fontSize: 15,
    fontWeight: FontWeight.normal,
    fontFamily: GoogleFonts.inter().fontFamily,
  ),
  TextStyle(
      color: whiteColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: GoogleFonts.inter().fontFamily),
  TextStyle(
      color: whiteColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      wordSpacing: 4,
      fontFamily: GoogleFonts.inter().fontFamily),
];
TextStyle errorStyle = TextStyle(
  color: Colors.red,
  fontSize: 15,
  fontWeight: FontWeight.bold,
  wordSpacing: 4,
  fontFamily: GoogleFonts.inter().fontFamily,
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => Manager()),
        ),
      ],
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: !isDarkTheme ? primaryColor : darkColor,
        ),
        child: DevicePreview(
          //enabled: !kReleaseMode,
          enabled: false,
          builder: (context) => MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            builder: (context, child) =>
                DevicePreview.appBuilder(context, child),
            title: 'Flemis',
            darkTheme: ThemeData.dark(),
            //home: const MobileLoginScreen(),
            initialRoute: "/splash",
            navigatorObservers: [
              observer,
            ],
            routes: {
              "/splash": (context) => const SplashScreen(),
              "/base": (context) => const MobileBase(),
              "/home": (context) => const MobileHome(),
              "/login": (context) => const MobileLoginScreen(),
              "/register": (context) => const MobileRegister(),
              "/edit": (context) => const MobileEditProfileScreen(),
              "/profile": (context) => const ProfileScreen(),
              "/chat": (context) => const MessageScreen(),
              "/createPost": (context) => const CreatePostScreen(),
              "/createStory": (context) => const CreateStoryScreen(),
              "/settings": (context) => const SettingsScreen(),
              "/createPostForm": (context) => const CreatePostScreenForms()
            },
          ),
        ),
      ),
    );
  }
}
