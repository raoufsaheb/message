import 'package:flutter/material.dart';
class MyLogo extends StatelessWidget {
  final String logo;
  final double size;
  final double radius;

  const MyLogo({required this.logo, required this.radius, required this.size});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: SizedBox.fromSize(
        size: Size.fromRadius(size),
        child: Image.asset(
          logo,
          fit: BoxFit.cover,
          height: 300.0,
        ),
      ),
    );
  }
}