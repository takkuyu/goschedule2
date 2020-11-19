import 'package:flutter/foundation.dart';
import 'package:goschedule2/models/company.dart';
import 'package:goschedule2/services/database.dart';

class CurrentGroup extends ChangeNotifier{
  OurCompany _currentCompany = OurCompany();

  OurCompany get getCurrentCompany => _currentCompany;

  void updateStateFromDatabase(String groupId) async{
    try{
      //get the groupInfo from firebase
      _currentCompany = await OurDatabase().getCompanyInfo(groupId);
      notifyListeners();
    }
    catch(e){
      print(e);
    }
  }
}