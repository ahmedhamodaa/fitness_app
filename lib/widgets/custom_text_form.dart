import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final String hinttext ;
  final bool isPassword ;
  final TextEditingController mycontroller ;
  final Widget? suffixIcon ;
  final String? Function(String?)? validator ;
  const CustomTextForm({super.key, required this.hinttext, required this.mycontroller,required this.validator, required this.isPassword, this.suffixIcon,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      validator: validator,
      controller: mycontroller ,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hinttext,
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide:
              BorderSide(color: const Color.fromARGB(255, 184, 184, 184))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}