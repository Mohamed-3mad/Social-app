import 'package:flutter/material.dart';

class CustomAuthButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomAuthButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: MaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.symmetric(vertical: 13),
          onPressed: onPressed,
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ));
  }
}
