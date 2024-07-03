import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  final double size;
  const MyLogo({super.key,required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size*0.2),
        child: Image.asset(
          'assets/logo/logo.png',
          height: size!=0? size:45,
        ),
      ),
    );
  }
}
