import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget customTextInput(
    {required BuildContext context,
    required String text,
    required String hint,
    bool isPassword = false,
    required TextEditingController controller,
    required TextInputType keyboardType,
    bool enabled = true}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      text.isNotEmpty
          ? (text).text.color(Vx.orange50).size(16).make()
          : 0.heightBox,
      5.heightBox,
      TextFormField(
        style: TextStyle(
            color: Color.lerp(Colors.pink, Colors.black, 0.3), fontSize: 24),
        enabled: enabled,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: isPassword,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: Colors.grey),
          hintText: hint,
          hintFadeDuration: const Duration(milliseconds: 400),
          isDense: true,
          fillColor: Colors.white.withOpacity(0.3),
          filled: true,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Vx.orange50, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Vx.orange50, width: 2),
          ),
        ),
      ),
    ],
  );
}
