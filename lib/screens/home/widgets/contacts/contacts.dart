import 'package:flutter/material.dart';
import 'package:goschedule2/models/user_data.dart';
import 'package:provider/provider.dart';

import 'contact_list.dart';

class OurContacts extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text("Dashboard", textScaleFactor: 2.0,)
    );
  }
}

//
// @override
// Widget build(BuildContext context) {
//
//   return StreamProvider<List<OurUser>>.value(
//     value: DatabaseService().employees,
//     child: Scaffold(
//       backgroundColor: Colors.brown[50],
//       body: Container(
//           child: ContactList()
//       ),
//     ),
//   );
// }