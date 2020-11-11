import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/carlo/Desktop/goschedule2/lib/screens/home/widgets/contacts/contacts.dart';
import 'package:goschedule2/screens/home/widgets/dashboard.dart';
import 'package:goschedule2/screens/home/widgets/profile.dart';
import 'package:goschedule2/screens/home/widgets/profile/profile_details.dart';
import 'package:goschedule2/screens/home/widgets/shifts.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int pageIndex = 0;

  final OurShifts _shifts = OurShifts();
  final OurDashboard _dashboard = OurDashboard();
  final ProfileDetails _profileDetails = ProfileDetails();
  final OurProfile _profile = OurProfile();
  // final OurContacts _contacts = OurContacts();

  Widget _showPage = new OurShifts();

  Widget _pageChooser(int page){
    switch (page) {
      case 0:
        return _dashboard;
        break;
      case 1:
        return _shifts;
        break;
      case 2:
        return _profile;
        break;
      case 3:
        return _profileDetails;
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
            //Icon(Icons.perm_identity, size: 30),
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
}
