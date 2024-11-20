import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final Color? color;
  final Color? textColor;

  const MyButton({super.key, 
    required this.text,
    required this.onPressed,
    this.color,  
    this.textColor,

  });

  @override
  Widget build(BuildContext context) {
    //check if color exist of uses default theme color.
    final buttonColor = color ?? Theme.of(context).primaryColor;
    final buttonTextColor = textColor ?? Colors.white;

    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          elevation: 8,  
          minimumSize: const Size(200,80),
          backgroundColor: buttonColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            ), 
        ),
        child: Text(
          text, 
          style:TextStyle(
            fontSize: 36,
            color: buttonTextColor,
          ),
        ),
      onPressed: () => onPressed(),
      ),
    );
  }
}
