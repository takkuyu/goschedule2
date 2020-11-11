import 'package:flutter/material.dart';
import 'package:goschedule2/screens/root/root.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

class OurProfile extends StatelessWidget {

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
    if(_returnString == "Success!"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget> [
          Text("Profile", textScaleFactor: 2.0,),
          RaisedButton(child: Text("Sign Out"), onPressed: () => _signOut(context),),
        ]
    );
  }
}

