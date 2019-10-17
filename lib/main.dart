import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:violet/theme/theme.dart';

import 'package:violet/screens/login.dart';
import 'package:violet/screens/splash_screen.dart';
import 'package:violet/screens/home.dart';

import 'package:violet/model/user_repository.dart';

void main() => runApp(Root());

class Root extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          Widget screen = LoginPage();
          switch (user.status) {
            case Status.AUTHENTICATED:
              print(user.user);
              screen = HomePage(title: user.user.displayName);
              break;
            case Status.AUTHENTICATING:
            case Status.UNAUTHENTICATED:
              screen = LoginPage();
              break;
            case Status.UNINITIALIZED:
              screen = Splash();
              break;
          }
          return MaterialApp(
            title: 'Violet',
            theme: violetLightTheme,
            home: screen,
          );
        },
      ),
    );
  }
}
