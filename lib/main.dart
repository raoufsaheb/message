import 'package:flutter/material.dart';
import 'package:message/pages/Login_page.dart';
import 'package:message/pages/message_page.dart';
import 'package:message/pages/signup_page.dart';
import 'pages/welcome_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);
final _auth = FirebaseAuth.instance;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: _auth.currentUser != null ? MessagePage.routePage : WelcomePage.routePage,

      routes: {
        WelcomePage.routePage: (context) => WelcomePage(),
        LoginPage.routePage: (context) => LoginPage(),
        SignUpPage.routePage: (context) => SignUpPage(),
        MessagePage.routePage: (context) => MessagePage(),
      },
    );
  }
}