import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goschedule2/models/user_data.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

class CreateShift extends StatefulWidget {
  @override
  _CreateShiftState createState() => _CreateShiftState();
}

class _CreateShiftState extends State<CreateShift> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  Future future;
  OurUser user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    future = _getEmployees();
  }
  

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: startTime,
    );
    if (picked != null) setState(() => startTime = picked);
  }
  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: endTime,
    );
    if (picked != null) setState(() => endTime = picked);
  }
  

  Future<List<OurUser>> _getEmployees() async {
    final data = await FirebaseFirestore.instance.collection('users').get();
    List<OurUser> users = data.docs.map<OurUser>((doc) => OurUser.fromFirestore(doc)).toList();
    return users;
  }

  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute/60.0;


  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of(context, listen: false);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text('Create Shift'), backgroundColor: Colors.white,),
      body: FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          List<OurUser> sameCompanyUser = snapshot.data.where((e) => (e.companyId == _currentUser.getCurrentUser.companyId && e.uid != _currentUser.getCurrentUser.uid)).toList();
          return Card(
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      Text('Select Date:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      Expanded(child: Container()),
                      Text("${selectedDate.toLocal()}".split(' ')[0]),
                      IconButton(icon: Icon(Icons.calendar_today), onPressed: () => _selectDate(context))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.white),
                      child: DropdownButton<OurUser>(
                        value: user,
                        isExpanded: true,
                        hint: Text('Employee'),
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        onChanged: (OurUser newValue) {
                          print(user);
                          print(newValue);
                          setState(() {
                            user = newValue;
                          });
                        },
                        items: sameCompanyUser.map<DropdownMenuItem<OurUser>>((OurUser value) {
                          return DropdownMenuItem<OurUser>(
                            value: value,
                            child: Text(value.fullName),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      Text('Start Time:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      Expanded(child: Container()),
                      Text("${startTime.format(context).toString()}"),
                      IconButton(icon: Icon(Icons.alarm), onPressed: () => _selectStartTime(context))
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 15,),
                      Text('End Time:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                      Expanded(child: Container()),
                      Text("${endTime.format(context).toString()}"),
                      IconButton(icon: Icon(Icons.alarm), onPressed: () => _selectEndTime(context))
                    ],
                  ),
                  Expanded(child: Container()),
                  RaisedButton(
                    onPressed: () async {
                      print(toDouble(startTime).toString());
                      print(toDouble(endTime).toString());
                      try {
                        if(selectedDate.compareTo(DateTime.now()) < 0) _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select a later date!')));
                        else if(toDouble(startTime) > toDouble(endTime)) _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select a later end time!')));
                        else if(user == null) _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Please select an employee!')));
                        else {
                          setState(() => isLoading = true);
                          DocumentReference doc = FirebaseFirestore.instance.collection('shifts').doc();
                          await doc.set({
                            'date': selectedDate,
                            'employeeId': user.companyId,
                            'employeeName': user.fullName, 
                            'startTime': startTime.format(context),
                            'endTime': endTime.format(context),
                          });
                          setState(() => isLoading = false);
                        } 
                      } catch (e) {
                        print(e);
                        throw e;
                      }
                    },
                    color: Colors.blue,
                    child: isLoading ? Container(width: 15, height: 15, child: CircularProgressIndicator())  
                    : Text('Create Shift', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}