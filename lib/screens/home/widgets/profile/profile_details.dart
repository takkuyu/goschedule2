import 'package:flutter/material.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProfileDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    CurrentUser _currentUser = Provider.of(context, listen: false);

    //ProfileDetails({Key key, this._currentUser}) : super(key: key);

    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
            child: Text(_currentUser.getCurrentUser.fullName[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20),),
          ),
          Container(width: double.infinity, alignment: Alignment.center, child: Text(_currentUser.getCurrentUser.fullName, style: TextStyle(fontWeight: FontWeight.bold),)),
          Container(width: double.infinity, alignment: Alignment.center, child: Text("POSITION")),
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
                          Text(_currentUser.getCurrentUser.phoneNo),
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
                          Text(_currentUser.getCurrentUser.email),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                      Text(_currentUser.getCurrentUser.monAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.tueAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.wedAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.thuAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.friAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.satAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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
                      Text(_currentUser.getCurrentUser.sunAvailability, style: TextStyle(fontWeight: FontWeight.bold),),
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