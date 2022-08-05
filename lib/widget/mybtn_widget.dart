import 'package:flutter/material.dart';
class Mybtn extends StatelessWidget {
  final colorofbtn;
  final onPressed;
  final coloroftext;
  final text;

  const Mybtn({required this.colorofbtn, required this.coloroftext, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorofbtn,
      borderRadius: BorderRadius.circular(30),
      elevation: 5,
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Cairo',
            color: coloroftext,
          ),
        ),
      ),
    );
  }
}
