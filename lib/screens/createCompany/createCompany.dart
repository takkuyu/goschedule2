import 'package:flutter/material.dart';
import 'package:goschedule2/screens/onBoarding/onBoarding.dart';
import 'package:goschedule2/services/database.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:goschedule2/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurCreateGroup extends StatefulWidget {
  @override
  _OurCreateGroupState createState() => _OurCreateGroupState();
}

class _OurCreateGroupState extends State<OurCreateGroup> {

  void _createGroup(BuildContext context, String companyName) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase().createCompany(companyName, _currentUser.getCurrentUser.uid);

    if(_returnString == "success!"){
      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurOnBoardingScreen()), (route) => false);
    }
  }

  TextEditingController _groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Company Name",
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                        ),
                      ),
                    ),
                    onPressed: () => _createGroup(context, _groupNameController.text),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
