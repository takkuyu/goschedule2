import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:goschedule2/screens/home/widgets/contacts/contacts.dart';
import 'package:goschedule2/screens/home/widgets/create_shift/create_shift.dart';
import 'package:goschedule2/screens/home/widgets/dashboard.dart';
import 'package:goschedule2/screens/home/widgets/profile/profile_details.dart';
import 'package:goschedule2/screens/home/widgets/shifts_activity.dart';
import 'package:goschedule2/states/currentGroup.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentGroup _currentCompany = Provider.of<CurrentGroup>(context, listen: false);
    _currentCompany.updateStateFromDatabase(_currentUser.getCurrentUser.companyId);
  }

  int pageIndex = 0;

  final OurShifts _shifts = OurShifts();
  final OurDashboard _dashboard = OurDashboard();
  final ProfileDetails _profileDetails = ProfileDetails();
  final OurContacts _contacts = OurContacts();
  final CreateShift _createShift = CreateShift();

  Widget _showPage = new OurDashboard();

  Widget _pageChooser(int page){
    switch (page) {
      case 0:
        return _dashboard;
        break;
      case 1:
        return _shifts;
        break;
      case 2:
        return _contacts;
        break;
      case 3:
        return _profileDetails;
        break;
      case 4:
        return _createShift;
        break;
      default:
        return new Container(
          child: new Center(
            child: new Text(
              "No page found by page chooser",
            ),
          ),
        );
    }
   }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of(context, listen: false);
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('companies').snapshots(),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
        List<String> managers = snapshot.data.documents.map<String>((data) => data.get('generalManager').toString()).toList();
        return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              key: _bottomNavigationKey,
              index: pageIndex,
              height: 50.0,
              items: <Widget>[
                Icon(Icons.dashboard, size: 30),
                Icon(Icons.calendar_today, size: 30),
                Icon(Icons.group, size: 30),
                Icon(Icons.person, size: 30),
                if(managers.contains(_currentUser.getCurrentUser.uid)) Icon(Icons.add, size: 30),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.blueAccent,
              animationCurve: Curves.easeInOut,
              animationDuration: Duration(milliseconds: 600),
              onTap: (int tappedIndex) {
                setState(() {
                  _showPage = _pageChooser(tappedIndex);
                });
              },
            ),
            body: Container(
              decoration: BoxDecoration(
              color: Colors.blueAccent,
              ),
              child: Center(
                child: _showPage,
              ),
            ));
      }
    );
  }
}
