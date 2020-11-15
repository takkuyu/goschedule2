import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser{
  String uid;
  String email;
  String fullName;
  Timestamp accountCreated;
  String companyId;
  String position;
  String phoneNo;
  String monAvailability;
  String tueAvailability;
  String wedAvailability;
  String thuAvailability;
  String friAvailability;
  String satAvailability;
  String sunAvailability;

  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
    this.companyId,
    this.position,
    this.phoneNo,
    this.monAvailability,
    this.tueAvailability,
    this.wedAvailability,
    this.thuAvailability,
    this.friAvailability,
    this.satAvailability,
    this.sunAvailability,
  });

  OurUser.fromFirestore(DocumentSnapshot data) {
    this.uid = data.id;
    this.fullName = data.get('fullName');
    this.companyId = data.get('companyId');
  }
}
