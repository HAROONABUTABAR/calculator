import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    super.key,
    this.textColor,
    required this.buttonText,
    this.color,
    this.onTap,
  });
  final color;
  final textColor;
  final String buttonText;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        // borderRadius: BorderRadius.circular(20),
        child: Container(
          color: color,
          child: Center(
              child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
            ),
          )),
        ),
      ),
    );
  }
}
