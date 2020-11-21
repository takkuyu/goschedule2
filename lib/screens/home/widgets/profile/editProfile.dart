import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:goschedule2/screens/home/home.dart';
import 'package:goschedule2/services/database.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../../home.dart';
import 'profile_details.dart';

class EditProfile extends StatefulWidget {
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  final FocusNode myFocusNode = FocusNode();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNo = TextEditingController();
  TextEditingController _position = TextEditingController();
  TextEditingController _monAvailability = TextEditingController();
  TextEditingController _tueAvailability = TextEditingController();
  TextEditingController _wedAvailability = TextEditingController();
  TextEditingController _thuAvailability = TextEditingController();
  TextEditingController _friAvailability = TextEditingController();
  TextEditingController _satAvailability = TextEditingController();
  TextEditingController _sunAvailability = TextEditingController();
  String _photoUrl = "empty";

  void _updateUserInfo(
      BuildContext context,
      String name,
      String phoneNo,
      String email,
      String position,
      String companyId,
      String monAvailability,
      String tueAvailability,
      String wedAvailability,
      String thuAvailability,
      String friAvailability,
      String satAvailability,
      String sunAvailability) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase().updateUserInformation(
        _currentUser.getCurrentUser.uid,
        name,
        email,
        phoneNo,
        position,
        companyId,
        monAvailability,
        tueAvailability,
        wedAvailability,
        thuAvailability,
        friAvailability,
        satAvailability,
        sunAvailability);

    if (_returnString == "success!") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  //pick image
  Future pickImage() async {
    File file = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200.0,
      maxWidth: 200.0,
    );
    String fileName = basename(_fullNameController.text);
    uploadImage(file, fileName);
  }

  //upload image
  void uploadImage(File file, String fileName) async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    image = await _picker.getImage(source: ImageSource.gallery);
    var file = File(image.path);

    if (image != null) {
      //Upload to Firebase
      var snapshot = await _storage
          .ref()
          .child('UserProfilePhotos/imageName')
          .putFile(file);

      var downloadUrl = await snapshot.ref.getDownloadURL();

      setState(() {
        _photoUrl = downloadUrl;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    CurrentUser _currentUser = Provider.of(context, listen: false);

    //get current user info
    _fullNameController.text = _currentUser.getCurrentUser.fullName;
    _phoneNo.text = _currentUser.getCurrentUser.phoneNo;
    _emailController.text = _currentUser.getCurrentUser.email;
    _position.text = _currentUser.getCurrentUser.position;
    _monAvailability.text = _currentUser.getCurrentUser.monAvailability;
    _tueAvailability.text = _currentUser.getCurrentUser.tueAvailability;
    _wedAvailability.text = _currentUser.getCurrentUser.wedAvailability;
    _thuAvailability.text = _currentUser.getCurrentUser.thuAvailability;
    _friAvailability.text = _currentUser.getCurrentUser.friAvailability;
    _satAvailability.text = _currentUser.getCurrentUser.satAvailability;
    _sunAvailability.text = _currentUser.getCurrentUser.sunAvailability;

    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.black,
            onPressed: () {
              _updateUserInfo(
                context,
                _fullNameController.text ??
                    _currentUser.getCurrentUser.fullName,
                _emailController.text ?? _currentUser.getCurrentUser.email,
                _phoneNo.text ?? _currentUser.getCurrentUser.phoneNo,
                _position.text ?? _currentUser.getCurrentUser.position,
                _currentUser.getCurrentUser.companyId,
                _monAvailability.text ??
                    _currentUser.getCurrentUser.monAvailability,
                _tueAvailability.text ??
                    _currentUser.getCurrentUser.tueAvailability,
                _wedAvailability.text ??
                    _currentUser.getCurrentUser.wedAvailability,
                _thuAvailability.text ??
                    _currentUser.getCurrentUser.thuAvailability,
                _friAvailability.text ??
                    _currentUser.getCurrentUser.friAvailability,
                _satAvailability.text ??
                    _currentUser.getCurrentUser.satAvailability,
                _sunAvailability.text ??
                    _currentUser.getCurrentUser.sunAvailability,
              );
            },
            child: Text(
              "Save",
              style: TextStyle(fontSize: 18.0),
            ),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            //FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            this.pickImage();
                          },
                          child: Center(
                            child: Container(
                                width: 150.0,
                                height: 150.0,
                                decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                        fit: BoxFit.cover,
                                        image: _photoUrl == "empty"
                                            ? AssetImage("assets/profile.jpg")
                                            : NetworkImage(_photoUrl)))),
                          ),
                        )),
                    Positioned(
                        bottom: 10,
                        right: 110,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  prefixIcon: Icon(Icons.person_outline),
                  //hintText: _currentUser.getCurrentUser.fullName,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _phoneNo,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_android_rounded),
                  //hintText: _currentUser.getCurrentUser.phoneNo,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  //hintText: _currentUser.getCurrentUser.email,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _position,
                decoration: InputDecoration(
                  labelText: 'Position',
                  prefixIcon: Icon(Icons.work_outline),
                  //hintText: _currentUser.getCurrentUser.position,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _monAvailability,
                decoration: InputDecoration(
                  labelText: 'Monday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.monAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _tueAvailability,
                decoration: InputDecoration(
                  labelText: 'Tuesday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.tueAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _wedAvailability,
                decoration: InputDecoration(
                  labelText: 'Wednesday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.wedAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _thuAvailability,
                decoration: InputDecoration(
                  labelText: 'Thursday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.thuAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _friAvailability,
                decoration: InputDecoration(
                  labelText: 'Friday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.friAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _satAvailability,
                decoration: InputDecoration(
                  labelText: 'Saturday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.satAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextFormField(
                controller: _sunAvailability,
                decoration: InputDecoration(
                  labelText: 'Sunday Availability',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  //hintText: _currentUser.getCurrentUser.sunAvailability,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      _updateUserInfo(
                        context,
                        _fullNameController.text ??
                            _currentUser.getCurrentUser.fullName,
                        _emailController.text ??
                            _currentUser.getCurrentUser.email,
                        _phoneNo.text ?? _currentUser.getCurrentUser.phoneNo,
                        _position.text ?? _currentUser.getCurrentUser.position,
                        _currentUser.getCurrentUser.companyId,
                        _monAvailability.text ??
                            _currentUser.getCurrentUser.monAvailability,
                        _tueAvailability.text ??
                            _currentUser.getCurrentUser.tueAvailability,
                        _wedAvailability.text ??
                            _currentUser.getCurrentUser.wedAvailability,
                        _thuAvailability.text ??
                            _currentUser.getCurrentUser.thuAvailability,
                        _friAvailability.text ??
                            _currentUser.getCurrentUser.friAvailability,
                        _satAvailability.text ??
                            _currentUser.getCurrentUser.satAvailability,
                        _sunAvailability.text ??
                            _currentUser.getCurrentUser.sunAvailability,
                      );
                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
