import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:violet/model/user_repository.dart';
import 'package:violet/theme/colors.dart';


/// Created by Xavier Chretien (apomalyn) on 10/07/2019
/// Login page
class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserRepository>(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 160),
                  SizedBox(
                    width: 42.0,
                    height: 42.0,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(color: primaryViolet),
                    ),
                  ),
                  SizedBox(height: 150),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 30.0),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        user.status == Status.AUTHENTICATING ?
                        CircularProgressIndicator() :
                        _buildGoogleButton(user)
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 30.0),
                    alignment: Alignment.center,
                    child: Row(
                      children: <Widget>[
                        user.status == Status.AUTHENTICATING ?
                        CircularProgressIndicator() :
                        _buildButton("Continue as anonymous", user)],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget _buildGoogleButton(UserRepository user) {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
          user.signInWithGoogle();
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                image: AssetImage('assets/images/google_logo.png'),
                height: 30.0),
            Container(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  "Sign in with Google",
                  style: TextStyle(color: primaryViolet),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, UserRepository user) {
    return Expanded(
      child: OutlineButton(
        onPressed: () {
          user.signInAnonymously();
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: primaryViolet,
        highlightedBorderColor: primaryViolet,
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 17.0,
            horizontal: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: primaryViolet),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
