import 'package:flutter/material.dart';
import 'package:goschedule2/screens/signup/localwidgets/signUpForm.dart';

class OurSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BackButton(),
                  ],
                ),
                SizedBox(height: 40.0),
                OurSignUpForm(),
              ],
            ),
          )
        ]  ,
      ),
    );
  }
}
