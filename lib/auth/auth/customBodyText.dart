import 'package:flutter/material.dart';

class CustomBodyText extends StatelessWidget {
  final String body;
  const CustomBodyText({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        body,
        textAlign: TextAlign.center,
        style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.grey),
      ),
    );
  }
}
