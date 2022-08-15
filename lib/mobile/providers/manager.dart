import 'package:flutter/material.dart';

import '../models/user.dart';

class Manager extends ChangeNotifier {
  User? user = User();
  ValueNotifier<int> currentPage = ValueNotifier<int>(2);

  void setUser(User? newUserValue) {
    user = newUserValue;
    notifyListeners();
  }

  void setCurrentPage(int currPageIndex) {
    currentPage.value = currPageIndex;
    currentPage.notifyListeners();
    notifyListeners();
  }
}
