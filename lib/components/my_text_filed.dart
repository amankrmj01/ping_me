import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final String text;
  final Icon icon;
  final TextEditingController controller;
  final bool visible;
  final TextInputType keyboardType;

  const MyTextField(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller,
      required this.visible,
      required this.keyboardType});

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late bool _obscureText;

  @override
  void initState() {
    _obscureText = widget.visible;
    super.initState();
  }

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        keyboardType: widget.keyboardType,
        onTapOutside: (event) {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        cursorColor: Colors.black,
        controller: widget.controller,
        obscureText: _obscureText,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        decoration: InputDecoration(
          hintFadeDuration: const Duration(milliseconds: 100),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 3, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Colors.amber.withRed(250)),
            borderRadius: BorderRadius.circular(10),
          ),
          hintText: widget.text,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.icon,
          suffixIcon: widget.text == 'Password'
              ? GestureDetector(
                  onTap: _toggleObscureText,
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
