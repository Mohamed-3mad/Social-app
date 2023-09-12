import 'package:flutter/material.dart';

class CustomTextformField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final IconData suffexIcon;
  final TextEditingController? mycontroller;
  final String? Function(String?) valid;
  final TextInputType? type;
  final bool? isobscure;
  final void Function()? onTapIcon;

  const CustomTextformField(
      {super.key,
      required this.hintText,
      required this.labelText,
      required this.suffexIcon,
      required this.mycontroller,
      required this.valid,
      required this.type, this.isobscure, this.onTapIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: type,
        validator: valid,
        controller: mycontroller,
        obscureText: isobscure==null || isobscure==false?false:true,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            label: Text(labelText),
            hintText: hintText,
            suffixIcon: InkWell(child: Icon(suffexIcon),onTap:onTapIcon ,),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
      ),
    );
  }
}
