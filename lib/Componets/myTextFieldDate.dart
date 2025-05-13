import 'package:flutter/material.dart';

class MyTextFieldDate extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final bool isDate;

  const MyTextFieldDate({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        readOnly: isDate, // 👈 Prevent keyboard for date field
        style: const TextStyle(color: Color(0xfff7e6ff)),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade200),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
        ),
        onTap: isDate
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  controller?.text =
                      "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                }
              }
            : null,
      ),
    );
  }
}
