import 'package:flutter/material.dart';
import 'package:message/pages/signup_page.dart';
import '../widget/MyLogo_widget.dart';
import '../widget/mybtn_widget.dart';
import 'Login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);
    static final routePage = '/welcome';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}


class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(58.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: MyLogo(logo: "images/message-icon.png", radius: 30.0, size: 100.0)
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Welcome to our app!',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Cairo',
                          color: Color.fromARGB(255, 92, 92, 16)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Mybtn(
              colorofbtn: Color.fromARGB(255, 255, 219, 42),
              coloroftext: Color.fromARGB(255, 4, 19, 41),
              text: "Login",
              onPressed: () {
                Navigator.of(context).pushNamed(LoginPage.routePage);
              
              },
            ),
            SizedBox(
              height: 20,
            ),
            Mybtn(
              colorofbtn: Color.fromARGB(255, 255, 255, 255),
              coloroftext: Color.fromARGB(255, 95, 87, 22),
              text: "sign up",
              onPressed: () {
                Navigator.of(context).pushNamed(SignUpPage.routePage);
              },
            ),
          ],
        ),
      ),
    );
  }
}

