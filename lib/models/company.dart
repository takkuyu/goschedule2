import 'package:cloud_firestore/cloud_firestore.dart';

class OurCompany{
  String id;
  String name;
  String generalManager;
  List<String> members;
  Timestamp companyCreated;

  OurCompany({
    this.id,
    this.name,
    this.generalManager,
    this.members,
    this.companyCreated,
  });
}