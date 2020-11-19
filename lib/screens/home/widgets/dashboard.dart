import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goschedule2/models/company.dart';
import 'package:goschedule2/models/user_data.dart';
import 'package:goschedule2/screens/root/root.dart';
import 'package:goschedule2/services/database.dart';
import 'package:goschedule2/states/currentGroup.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

class OurDashboard extends StatefulWidget {
  @override
  _OurDashboardState createState() => _OurDashboardState();
}

class _OurDashboardState extends State<OurDashboard> {

  final key = new GlobalKey<ScaffoldState>();

  void _signOut(BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentUser.signOut();
    if(_returnString == "Success!"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  void _leaveCompany(BuildContext context) async {
    OurCompany company = Provider.of<OurCompany>(context, listen: false);
    OurUser user = Provider.of<OurUser>(context, listen: false);

    String _returnString = await OurDatabase().leaveGroup(company.id, user.uid);
    if(_returnString == "Success!"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  void _copyGroupId(BuildContext context){
    OurCompany company = Provider.of<OurCompany>(context, listen: false);
    Clipboard.setData(ClipboardData(text: company.id));

    key.currentState.showSnackBar(SnackBar(content: Text('Copied!'),));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: key,
        appBar: AppBar(
        title:Consumer<CurrentGroup>(
          builder: (BuildContext context, value, Widget child) {
            return Text(value.getCurrentCompany.name ?? "Loading..", textScaleFactor: 1.0);},),
        backgroundColor: Colors.white,
        centerTitle: true,),
        body: ListView(
          children: <Widget>[

            Padding(padding: EdgeInsets.all(20.0),child: Image(
              image: AssetImage(
                'assets/Logo.PNG',
              ),
              height: 300.0,
              width: 300.0,
            ),
            ),
            SizedBox(height: 35.0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: RaisedButton(
                  child: Text(
                    "Copy Company Id",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                onPressed: () => _copyGroupId(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: RaisedButton(
                  child: Text(
                    "Leave Company",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                onPressed: () => _leaveCompany(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: RaisedButton(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                onPressed: () => _signOut(context),
              ),
            ),
            ],
        ),
    );
  }
}
