import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goschedule2/models/user_data.dart';
import 'contact_details.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Colors.white,
        centerTitle: true,
        bottom: PreferredSize(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Theme(
              data: ThemeData(primaryColor: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: searchController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
                    isDense: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black),
                    prefixIcon: Icon(Icons.search, color: Colors.black,),
                  ),
                ),
              ),
            ),
          ),
          preferredSize: Size.fromHeight(50),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                OurUser employee = OurUser.fromFirestore(snapshot.data.documents[index]);
                if(employee.fullName.toLowerCase().contains(searchController.text.toLowerCase()) || searchController.text.length == 0)
                  return ListTile(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ContactDetails(user: employee,))),
                    title: Text(employee.fullName),
                    leading: Container(
                      width: 40,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Text(employee.fullName[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20),),
                    ),
                  );
                else return Container(
                    child: Text("No Content"));
              },
            );
          }
      ),
    );
  }
}
