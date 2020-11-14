import 'package:flutter/material.dart';
import 'package:goschedule2/models/user_data.dart';
import 'package:goschedule2/services/database.dart';
import 'package:provider/provider.dart';
import 'contact_list.dart';

class OurContacts extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return StreamProvider<List<OurUser>>.value(
      value: OurDatabase().users,
      child: Scaffold(
        body: Container(
            child: ContactList(),
        ),
      ),
    );
  }
}
