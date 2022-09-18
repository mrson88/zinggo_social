import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton(
      {required this.color,
      required this.onPressed,
      required this.gradient,
      required this.size,
      required this.text,
      required this.height});
  final Color color;
  final Function() onPressed;
  final Gradient? gradient;
  final double size;
  final String text;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: gradient,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(color: color, fontSize: size),
        ),
      ),
    );
  }
}
