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
                Padding(padding: EdgeInsets.all(40.0),child: Text('GoSchedule', style: TextStyle(
                fontSize: 53.0, fontWeight: FontWeight.bold, color: Colors.white
                ),),
                ),
                SizedBox(height: 20.0),
                OurLoginForm(),
              ],
            ),
          )
        ]  ,
      ),
    );
  }
}
