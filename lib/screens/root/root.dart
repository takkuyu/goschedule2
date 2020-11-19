import 'package:flutter/material.dart';
import 'package:goschedule2/screens/home/home.dart';
import 'package:goschedule2/screens/login/login.dart';
import 'package:goschedule2/screens/noCompany/noCompany.dart';
import 'package:goschedule2/screens/splashScreen/splashScreen.dart';
import 'package:goschedule2/states/currentGroup.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

enum AuthStatus {
  unknown,
  notLoggedIn,
  notInCompany,
  inCompany,
}
class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {

  AuthStatus _authStatus = AuthStatus.unknown;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    //get the state, check current user, set AuthStatus base on state
    CurrentUser _currentUser = Provider.of(context, listen: false);
    String _returnString = await _currentUser.onStartUp();
    if(_returnString == "success!"){
      if(_currentUser.getCurrentUser.companyId != null){
        setState(() {
          _authStatus = AuthStatus.inCompany;
        });
      }
      else {
        setState(() {
          _authStatus = AuthStatus.notInCompany;
        });
      }
    }
    else {
      setState(() {
        _authStatus = AuthStatus.notLoggedIn;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch(_authStatus) {
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.notLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.notInCompany:
        retVal = OurNoCompany();
        break;
      case AuthStatus.inCompany:
        retVal = ChangeNotifierProvider(
          create: (context) => CurrentGroup(),
          child: HomeScreen(),
        );

        break;
      default:
    }

    return retVal;
  }
}
