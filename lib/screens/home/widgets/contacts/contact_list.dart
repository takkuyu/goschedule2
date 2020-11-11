// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:goschedule2/screens/home/widgets/profile/profile_details.dart';
//
// class ContactList extends StatefulWidget {
//   @override
//   _ContactListState createState() => _ContactListState();
// }
//
// class _ContactListState extends State<ContactList> {
//   TextEditingController searchController = TextEditingController();
//
//   @override
//   void initState() {
//     searchController.addListener(() => setState(() {}));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contacts'),
//         centerTitle: true,
//         bottom: PreferredSize(
//           child: Padding(
//             padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
//             child: Theme(
//               data: ThemeData(primaryColor: Colors.white),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: TextField(
//                   controller: searchController,
//                   cursorColor: Colors.white,
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
//                     isDense: true,
//                     fillColor: Colors.white,
//                     focusColor: Colors.white,
//                     hintText: 'Search',
//                     hintStyle: TextStyle(color: Colors.grey[100]),
//                     prefixIcon: Icon(Icons.search, color: Colors.white,),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           preferredSize: Size.fromHeight(50),
//         ),
//       ),
//       body: StreamBuilder(
//           stream: FirebaseFirestore.instance.collection('Employee').snapshots(),
//           builder: (context, snapshot) {
//             if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
//             return ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               itemBuilder: (context, index) {
//                 Employee employee = Employee.fromFirestore(snapshot.data.documents[index]);
//                 if(employee.name.toLowerCase().contains(searchController.text.toLowerCase()) || searchController.text.length == 0)
//                   return ListTile(
//                     onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileDetails(employee: employee,))),
//                     title: Text(employee.name),
//                     leading: Container(
//                       width: 40,
//                       height: 40,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         shape: BoxShape.circle,
//                       ),
//                       child: Text(employee.name[0].toUpperCase(), style: TextStyle(color: Colors.white, fontSize: 20),),
//                     ),
//                   );
//                 else return Container();
//               },
//             );
//           }
//       ),
//     );
//   }
// }
