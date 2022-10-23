import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/user.dart';

class FirebaseService {
  final analytics = FirebaseAnalytics.instance;

  void accessAccountLog(User user) {
    analytics.logEvent(
        name: "Access account",
        parameters: {"userId": user.id, "username": user.username});
  }
}
