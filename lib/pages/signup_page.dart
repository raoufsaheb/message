import 'package:flutter/material.dart';
import 'package:message/widget/MyLogo_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widget/mybtn_widget.dart';
import 'message_page.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);
  static final routePage = '/signup';

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  late String _email, _password;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
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
                child: Text(
                  'Welcome !',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Color.fromARGB(28, 0, 0, 0),
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                      fontSize: 30,
                      fontFamily: 'Cairo',
                      color: Color.fromARGB(255, 92, 92, 16)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  _email = value;
                },
                decoration: const InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 4, 19, 41),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 236, 24), width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                obscureText: true,
                onChanged: (value) {
                  _password = value;
                },
                decoration: const InputDecoration(
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 4, 19, 41),
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
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 255, 236, 24), width: 2),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Mybtn(
                colorofbtn: Color.fromARGB(255, 4, 19, 41),
                coloroftext: Color.fromARGB(255, 255, 255, 255),
                text: "Sign Up",
                onPressed: () async {
                  setState(() {
                    spinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    );
                      Navigator.of(context).pushNamed(MessagePage.routePage);
                      setState(() {
                    spinner = false;
                  });
                  } catch (e) {
                    print(e);
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
