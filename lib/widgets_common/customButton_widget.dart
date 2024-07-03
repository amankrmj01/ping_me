

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customButton({
  required BuildContext context,
  required String text,
  Color backgroundColor = Colors.amber,
  Color textColor = Colors.white,
  Color overlayColor = Colors.amber,
  required VoidCallback onPressed,
  double size = 24,
  double height = 50,
}) {
  return Container(
    width: context.screenWidth * 0.8,
    height: height,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
      color: backgroundColor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextButton(
      style: TextButton.styleFrom(
        splashFactory: InkRipple.splashFactory,
        animationDuration: const Duration(seconds: 2),
        overlayColor: overlayColor,
      ),
      onPressed: onPressed,
      child: Center(
        child: text.text.color(textColor).size(size).make(),
      ),
    ),
  );
}
