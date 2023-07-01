import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;

  const EditProfileButton(
      {Key? key,
      required this.backgroundColor,
      required this.borderColor,
      required this.function,
      required this.text,
      required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 28),
        child: TextButton(
            onPressed: function,
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              width: 250,
              height: 27,
            )));
  }
}
