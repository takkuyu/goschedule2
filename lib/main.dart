import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:goschedule2/screens/root/root.dart';
import 'package:goschedule2/states/currentUser.dart';
import 'package:goschedule2/utils/ourTheme.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
          home: OurRoot(),
        ),
    );
  }
}
