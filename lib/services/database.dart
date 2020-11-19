import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:goschedule2/models/company.dart';
import 'package:goschedule2/models/user_data.dart';

class OurDatabase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try{
      await _firestore.collection("users").doc(user.uid).set({
        'fullName' : user.fullName,
        'email' :user.email,
        'accountCreated' : Timestamp.now(),
        'phoneNo' : 'NOT_SET',
        'position' : 'NOT_SET',
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
      retVal.position = _docSnapshot.data()["position"];
      retVal.email = _docSnapshot.data()['email'];
      retVal.companyId = _docSnapshot.data()["companyId"];
      retVal.phoneNo = _docSnapshot.data()["phoneNo"];
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

  Future<OurCompany> getCompanyInfo(String groupId) async {
    OurCompany retVal = OurCompany();

    try{
      DocumentSnapshot _docSnapshot = await _firestore.collection("companies").doc(groupId).get();
      retVal.id = groupId;
      retVal.name = _docSnapshot.data()["name"];
      retVal.generalManager = _docSnapshot.data()['generalManager'];
      retVal.members = List<String>.from(_docSnapshot.data()["members"]);
      retVal.companyCreated = _docSnapshot.data()['companyCreated'];
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

  //Update User availability
  Future updateUserInformation(String uid, String name, String email, String phoneNo, String position, String companyId, String monAvailability, String tueAvailability, String wedAvailability, String thuAvailability, String friAvailability, String satAvailability, String sunAvailability,) async {
    String retVal = "error";
    try{
      await _firestore.collection("users").doc(uid).set({
        'fullName' : name,
        'phoneNo' : phoneNo,
        'position' : position,
        'companyId' : companyId,
        'email' : email,
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
      print("_"+ companyId + "_");
    }

    return retVal;
  }

  Future<String> leaveGroup(String companyId, String userUid) async {
    String retVal = "error";
    List<String> members = List();

    try{
      members.add(userUid);

      await _firestore.collection("companies").doc(companyId).update({
        'members' : FieldValue.arrayRemove(members),
      });
      await  _firestore.collection("users").doc(userUid).update({
        'companyId' : null,
      });
    }

    catch(e){
      print(e);
      print("_"+ companyId + "_");
    }

    return retVal;
  }

  ///EDIT FROM HERE
  //Employee list from snapshot
  List<OurUser> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return OurUser(
          fullName: doc.data()['name'] ?? 'UNDEFINED',
          phoneNo: doc.data()['phoneNo'] ?? 'UNDEFINED',
          email: doc.data()['email'] ?? 'UNDEFINED',
          position: doc.data()['position'] ?? 'UNDEFINED',
          monAvailability: doc.data()['mondayAvailability'] ?? 'UNDEFINED',
          tueAvailability: doc.data()['tuesdayAvailability'] ?? 'UNDEFINED',
          wedAvailability: doc.data()['wednesdayAvailability'] ?? 'UNDEFINED',
          thuAvailability: doc.data()['thursdayAvailability'] ?? 'UNDEFINED',
          friAvailability: doc.data()['fridayAvailability'] ?? 'UNDEFINED',
          satAvailability: doc.data()['saturdayAvailability'] ?? 'UNDEFINED',
          sunAvailability: doc.data()['sundayAvailability'] ?? 'UNDEFINED'
      );
    }).toList();
  }

  //Get employee streams
  Stream<List<OurUser>> get users {
    return _usersCollection.snapshots().map(_userListFromSnapshot);
  }
  ///UNTIL HERE!!
}