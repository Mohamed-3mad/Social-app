import 'package:flutter/material.dart';

class CustomTextButtonForSignInOrSignUp extends StatelessWidget {
  final String textone, texttwo;
  final void Function()? onTap;
  const CustomTextButtonForSignInOrSignUp(
      {super.key, required this.textone, required this.texttwo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textone),
        InkWell(
          onTap: onTap,
          child: Text(
            texttwo,
            style: const TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
