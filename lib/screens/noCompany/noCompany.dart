import 'package:flutter/material.dart';
import 'package:goschedule2/screens/createCompany/createCompany.dart';
import 'package:goschedule2/screens/joinCompany/joinCompany.dart';

class OurNoCompany extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _goToJoin(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OurJoinCompany()),);
    }
    void _goToCreate(BuildContext context){
      Navigator.push(context, MaterialPageRoute(builder: (context) => OurCreateGroup()),);
    }

    return Scaffold(
      body: Column(children: <Widget>[
        Spacer(flex: 1,),
        Padding(padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 80.0),child: Image.asset("assets/Logo.PNG"),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text("Welcome to GoSchedule!", textAlign: TextAlign.center, style: TextStyle(fontSize: 30.0, color: Colors.white),),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text("Would you like to join an existing company or would you like to add your company?", textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.white),),
        ),
        Spacer(flex: 1,),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('Create'),
                onPressed: () => _goToCreate(context),
                color: Theme.of(context).canvasColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor,
                    width: 2,
                  ),
                ),
              ),
              RaisedButton(
                child: Text('Join', style: TextStyle( color: Colors.white),),
                onPressed: () => _goToJoin(context),

              ),
            ],),
        )
      ],),
    );
  }
}
