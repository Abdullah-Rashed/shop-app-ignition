import 'package:flutter/material.dart';
import 'package:shop_app/app/get_it/get_it.dart';

class AppRouter {
  //route and  remove  the  Current screen
  static pushReplace({required Widget screen}) {
    return navKey.currentState!.pushReplacement(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

// route without remove anything
  static Future push({required Widget screen}) {
    return navKey.currentState!.push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

// Route and Remove all All pages in the stack
  static removeUntil({required Widget screen}) {
    return navKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
      (route) => false,
    );
  }

// GO BACK
  static pop({var dataToSendBack, BuildContext? specificContext}) {
    return specificContext == null
        ? navKey.currentState!.pop(dataToSendBack)
        : Navigator.of(specificContext).pop();
  }
}
