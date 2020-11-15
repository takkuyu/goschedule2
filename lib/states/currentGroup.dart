import 'package:flutter/foundation.dart';
import 'package:goschedule2/models/company.dart';
import 'package:goschedule2/screens/home/widgets/shifts_activity.dart';

class CurrentGroup extends ChangeNotifier{
  OurCompany _currentCompany = OurCompany();
  OurShifts _shifts = OurShifts();

  OurCompany get getCurrentCompany => _currentCompany;
  OurShifts get getCurrentShifts => _shifts;

  void updateStateFromDatabase(String groupId) async{
    try{
      //get the groupInfo from firebase

    }
    catch(e){
      print(e);
    }
  }
}