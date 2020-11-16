import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:goschedule2/screens/home/home.dart';
import 'package:goschedule2/services/database.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:provider/provider.dart';



class EditProfile extends StatefulWidget{
  @override
  MapScreenState createState() => MapScreenState();
}

class MapScreenState extends State<EditProfile> with SingleTickerProviderStateMixin {
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

  void _updateUserInfo(BuildContext context, String name, String phoneNo, String email, String position,String companyId, String monAvailability, String tueAvailability, String wedAvailability, String thuAvailability, String friAvailability, String satAvailability, String sunAvailability) async{
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await OurDatabase().updateUserInformation(_currentUser.getCurrentUser.uid, name, email, phoneNo, position, companyId, monAvailability, tueAvailability, wedAvailability,thuAvailability, friAvailability, satAvailability, sunAvailability);

    if(_returnString == "success!"){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    CurrentUser _currentUser = Provider.of(context, listen: false);

    return new Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60,
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
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
                  hintText: _currentUser.getCurrentUser.fullName,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _phoneNo,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: _currentUser.getCurrentUser.phoneNo,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: _currentUser.getCurrentUser.email,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _position,
                decoration: InputDecoration(
                  labelText: 'Position',
                  hintText: _currentUser.getCurrentUser.position,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _monAvailability,
                decoration: InputDecoration(
                  labelText: 'Monday Availability',
                  hintText: _currentUser.getCurrentUser.monAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _tueAvailability,
                decoration: InputDecoration(
                  labelText: 'Tuesday Availability',
                  hintText: _currentUser.getCurrentUser.tueAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _wedAvailability,
                decoration: InputDecoration(
                  labelText: 'Wednesday Availability',
                  hintText: _currentUser.getCurrentUser.wedAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _thuAvailability,
                decoration: InputDecoration(
                  labelText: 'Thursday Availability',
                  hintText: _currentUser.getCurrentUser.thuAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _friAvailability,
                decoration: InputDecoration(
                  labelText: 'Friday Availability',
                  hintText: _currentUser.getCurrentUser.friAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _satAvailability,
                decoration: InputDecoration(
                  labelText: 'Saturday Availability',
                  hintText: _currentUser.getCurrentUser.satAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: _sunAvailability,
                decoration: InputDecoration(
                  labelText: 'Sunday Availability',
                  hintText: _currentUser.getCurrentUser.sunAvailability,
                ),
              ),
              SizedBox(height: 20.0,),
              Row(
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
                      _updateUserInfo(context,
                        _fullNameController.text ?? _currentUser.getCurrentUser.fullName,
                        _emailController.text ?? _currentUser.getCurrentUser.email,
                        _phoneNo.text ?? _currentUser.getCurrentUser.phoneNo,
                        _position.text ?? _currentUser.getCurrentUser.position,
                        _currentUser.getCurrentUser.companyId,
                        _monAvailability.text ?? _currentUser.getCurrentUser.monAvailability,
                        _tueAvailability.text ?? _currentUser.getCurrentUser.tueAvailability,
                        _wedAvailability.text ?? _currentUser.getCurrentUser.wedAvailability,
                        _thuAvailability.text ?? _currentUser.getCurrentUser.thuAvailability,
                        _friAvailability.text ?? _currentUser.getCurrentUser.friAvailability,
                        _satAvailability.text ?? _currentUser.getCurrentUser.satAvailability,
                        _sunAvailability.text ?? _currentUser.getCurrentUser.sunAvailability,
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
              SizedBox(height: 20.0,)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
      ),
    );
  }
}
