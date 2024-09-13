/*
import 'package:flutter/material.dart';

import '../Auth/SignInScreen.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.hintText,
    this.obscureText = false,
    this.validator,
  });

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscure = false;

  @override
  void initState() {
    super.initState();
    if (widget.obscureText) {
      _obscure = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFf1f0f5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        keyboardType: widget.keyboardType,
        obscureText: _obscure,
        obscuringCharacter: '*',
        validator: widget.validator,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? Padding(
                  padding: EdgeInsets.all(4),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(64),
                      child: Icon(
                        _obscure ? Icons.visibility : Icons.visibility_off,
                      ),
                      onTap: () {
                        setState(() {
                          // hidePassword;
                          _obscure = !_obscure;



                        });
                      },
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
*/
