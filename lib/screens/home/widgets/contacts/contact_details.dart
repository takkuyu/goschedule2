import 'package:flutter/material.dart';
import 'package:goschedule2/models/user_data.dart';

class ContactDetails extends StatelessWidget {
  final OurUser user;

  const ContactDetails({Key key, this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Employee Details'),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Container(
            width: 80,
            height: 80,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Text(user.fullName[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          Container(width: double.infinity, alignment: Alignment.center, child: Text(user.fullName, style: TextStyle(fontWeight: FontWeight.bold),)),
          // Container(width: double.infinity, alignment: Alignment.center, child: Text(user.position)),
          Container(width: double.infinity, alignment: Alignment.center, child: Text("employee.position")),
          Card(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.phone, size: 32,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mobile'),
                          // Text(employee.phoneNo),
                          Text('employee.phoneNo'),
                        ],
                      )
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Icon(Icons.email, size: 32,),
                      SizedBox(width: 20,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email'),
                          // Text(employee.email),
                          Text('employee.email'),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Monday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.monAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.monAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tuesday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.tueAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.tueAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Wednsday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.wedAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.wedAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Thursday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.thuAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.thuAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Friday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.friAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.friAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Saturday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.satAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.satAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sunday', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('09:00 AM - 06:00 PM', style: TextStyle(fontSize: 10),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      // Text(employee.sunAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('employee.sunAvailability', style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}