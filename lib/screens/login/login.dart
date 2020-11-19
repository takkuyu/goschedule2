import 'package:flutter/material.dart';
import 'package:goschedule2/screens/login/localwidgets/loginform.dart';

class OurLogin extends StatelessWidget {
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
                Padding(padding: EdgeInsets.all(20.0),child: Image(
                  image: AssetImage(
                    'assets/Logo.PNG',
                  ),
                  height: 230.0,
                  width: 250.0,
                ),
                ),
                OurLoginForm(),
              ],
            ),
          )
        ]  ,
      ),
    );
  }
}
