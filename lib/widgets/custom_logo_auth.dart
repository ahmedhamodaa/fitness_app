import 'package:flutter/material.dart';

class CustomLogoAuth extends StatelessWidget {
  const CustomLogoAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          alignment: Alignment.center,
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Color(0xff169E3C),
              borderRadius: BorderRadius.circular(70)),
          child: Image.asset(
            "assets/images/logo.png",
            height: 55,
            // fit: BoxFit.fill,
          )),
    );
  }
}