import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:message/pages/message_page.dart';
import '../widget/mybtn_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static final routePage = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
final _auth = FirebaseAuth.instance;
    late String Email, Password;
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            // feildtext login
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.topCenter,
                child: const Text(
                  'Welcome again!',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(28, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 20,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 92, 92, 16)),
                ),
              ),
              const SizedBox(
                height: 70,
              ),
              TextField(
        autofocus: true,
        onChanged: (value){
          Email = value;
        
        },
        decoration: const InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
            color:  Color.fromARGB(255, 4, 19, 41),
            fontSize: 20,
            fontFamily: 'Cairo',
          ),
          suffixIcon: Icon(
            Icons.email,
            color: Color.fromARGB(255, 10, 55, 88),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 197, 74, 74),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 236, 24), width: 2),
          ),
        ),
          ),
              const SizedBox(
                height: 20,
              ),
              TextField(
        obscureText: true,
        onChanged: (value){
          Password = value;
        },
        decoration: const InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
            color:  Color.fromARGB(255, 4, 19, 41),
            fontSize: 20,
            fontFamily: 'Cairo',
          ),
          suffixIcon: Icon(
            Icons.lock,
            color: Color.fromARGB(255, 10, 55, 88),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 197, 74, 74),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 255, 236, 24), width: 2),
          ),
        ),
          ),
              const SizedBox(
                height: 40,
              ),
              Mybtn(
                colorofbtn: const Color.fromARGB(255, 247, 226, 87),
                coloroftext: const Color.fromARGB(255, 4, 19, 41),
                text: "Login",
                onPressed: () async{
                  setState(() {
                    spinner = true;
                  });
                  try {
                    
                    final user = await _auth.signInWithEmailAndPassword(
                        email: Email, password: Password);
                        if(user != null){
                          Navigator.pushNamed(context, MessagePage.routePage);
                         setState(() {
                    spinner = false;
                  });
                        }
                  } catch (e) {
                    print(e);
                     setState(() {
                    spinner = false;
                  });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
