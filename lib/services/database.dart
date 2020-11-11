import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goschedule2/models/user_data.dart';

class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try{
      await _firestore.collection("users").doc(user.uid).set({
        'fullName' : user.fullName,
        'email' :user.email,
        'accountCreated' : Timestamp.now(),
        'phoneNo' : 'NOT_SET',
        'mondayAvailability' : 'NOT_SET',
        'tuesdayAvailability' : 'NOT_SET',
        'wednesdayAvailability' : 'NOT_SET',
        'thursdayAvailability' : 'NOT_SET',
        'fridayAvailability' : 'NOT_SET',
        'saturdayAvailability' : 'NOT_SET',
        'sundayAvailability' : 'NOT_SET',
      });
      retVal = 'success!';
    }
    catch(e){
      print(e);
    }

    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      retVal.fullName = _docSnapshot.data()["fullName"];
      retVal.email = _docSnapshot.data()['email'];
      retVal.accountCreated = _docSnapshot.data()["accountCreated"];
      retVal.companyId = _docSnapshot.data()["companyId"];
      retVal.phoneNo = _docSnapshot.data()["companyId"];
      retVal.monAvailability = _docSnapshot.data()["mondayAvailability"];
      retVal.tueAvailability = _docSnapshot.data()["tuesdayAvailability"];
      retVal.wedAvailability = _docSnapshot.data()["wednesdayAvailability"];
      retVal.thuAvailability = _docSnapshot.data()["thursdayAvailability"];
      retVal.friAvailability = _docSnapshot.data()["fridayAvailability"];
      retVal.satAvailability = _docSnapshot.data()["saturdayAvailability"];
      retVal.sunAvailability = _docSnapshot.data()["sundayAvailability"];
    }
    catch(e){
      print(e);
    }
    return retVal;
  }

  Future<String> createCompany(String companyName, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    try{
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("companies").add({
        'name' : companyName,
        'generalManager' : userUid,
        'members' : members,
        'companyCreated' : Timestamp.now(),
      });

      _firestore.collection("users").doc(userUid).update({
        'companyId' : _docRef.id,
      });
      retVal = 'success!';
    }
    catch(e){
      print(e);
    }

    return retVal;
  }

  //Update User phone number
  Future updateUserPhoneNo(String uid, String phoneNo) async {
    String retVal = "error";
    try{
      await _firestore.collection("users").doc(uid).set({
        'phoneNo' : phoneNo,
      });
      retVal = 'success!';
    }
    catch(e){
      print(e);
    }

    return retVal;
  }

  //Update User availability
  Future updateUserAvailability(String uid, String monAvailability, String tueAvailability, String wedAvailability, String thuAvailability, String friAvailability, String satAvailability, String sunAvailability,) async {
    String retVal = "error";
    try{
      await _firestore.collection("users").doc(uid).set({
        'mondayAvailability' : monAvailability,
        'tuesdayAvailability' : tueAvailability,
        'wednesdayAvailability' : wedAvailability,
        'thursdayAvailability' : thuAvailability,
        'fridayAvailability' : friAvailability,
        'saturdayAvailability' : satAvailability,
        'sundayAvailability' : sunAvailability,
      });
      retVal = 'success!';
    }
    catch(e){
      print(e);
    }

    return retVal;
  }


  Future<String> joinCompany(String companyId, String userUid) async {
    String retVal = "error";
    List<String> members = List();
    
    try{
      members.add(userUid);
      await _firestore.collection("companies").doc(companyId).update({
        "members" : FieldValue.arrayUnion(members),
      });
      _firestore.collection("users").doc(userUid).update({
      'companyId' : companyId,
      });
      retVal = 'success!';
    }
    catch(e){
      print(e);
    }

    return retVal;
  }
}