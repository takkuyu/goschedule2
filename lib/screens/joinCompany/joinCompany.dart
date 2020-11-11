import 'package:flutter/material.dart';
import 'package:goschedule2/screens/root/root.dart';
import 'package:goschedule2/services/database.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:goschedule2/widgets/ourContainer.dart';
import 'package:provider/provider.dart';

class OurJoinCompany extends StatefulWidget {
  @override
  _OurJoinCompanyState createState() => _OurJoinCompanyState();
}

class _OurJoinCompanyState extends State<OurJoinCompany> {

  void _joinGroup(BuildContext context, String companyId) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase().joinCompany(companyId, _currentUser.getCurrentUser.uid);

    if(_returnString == "success!"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  TextEditingController _groupIdController = TextEditingController();

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
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Join",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0
                        ),
                      ),
                    ),
                    onPressed: () => _joinGroup(context, _groupIdController.text),
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
