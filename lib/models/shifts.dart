import 'package:cloud_firestore/cloud_firestore.dart';

class Shifts {
  String id;
  String employee;
  String employeeId;
  String position;
  String date;
  String startTime;
  String endTime;

  Shifts({
    this.id,
    this.employee,
    this.employeeId,
    this.position,
    this.date,
    this.startTime,
    this.endTime,
  });

  Shifts.fromFirebase(DocumentSnapshot data) {
    this.id = data.id;
    this.employeeId = data.get('employeeId');
    this.employee = data.get('employeeName');
    this.date = data.get('fullName');
    this.startTime = data.get('startTime');
    this.endTime = data.get('endTime');
  }
}
