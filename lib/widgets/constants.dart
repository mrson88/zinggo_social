import 'package:flutter/material.dart';
import 'package:zinggo_social/themes/app_color.dart';
import 'package:email_validator/email_validator.dart';

class nInputDecoration extends StatelessWidget {
  nInputDecoration({
    required this.text,
    required this.obs,
    required this.controller,
  });
  final String text;
  final bool obs;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,

        textAlign: TextAlign.start,
        obscureText: obs,

        // onChanged: (value) {
        //   //Do something with the user input.
        //
        // },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.blur,
          hintText: text,
          hintStyle: const TextStyle(color: AppColors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
        ),
      ),
    );
  }
}

class kInputDecoration extends StatelessWidget {
  kInputDecoration({
    required this.text,
    required this.obs,
  });
  final String text;
  final bool obs;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: TextInputType.text,
        textAlign: TextAlign.start,
        obscureText: obs,
        onChanged: (value) {
          //Do something with the user input.
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.blur,
          hintText: text,
          hintStyle: const TextStyle(color: AppColors.white),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(22.0)),
          ),
        ),
      ),
    );
  }
}
