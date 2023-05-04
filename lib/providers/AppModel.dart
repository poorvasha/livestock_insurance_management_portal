import 'package:flutter/material.dart';

import '../configs/Routes.dart' as routes;

class AppModel with ChangeNotifier {
  String? _intialRoute = routes.Routes.masterDataEntryScreen;
  String? get getInitialRoute {
    return _intialRoute;
  }

  set setInitialRoute(String? route) {
    _intialRoute = route;
    notifyListeners();
  }
}
