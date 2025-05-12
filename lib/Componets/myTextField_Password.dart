import 'package:flutter/material.dart';

class MyTextFielPassword extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;

  const MyTextFielPassword({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<MyTextFielPassword> createState() => _MyTextFielPasswordState();
}

class _MyTextFielPasswordState extends State<MyTextFielPassword> {
  bool obscureText =
      true; // Estado para controlar la visibilidad de la contraseña

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: widget.controller,
        obscureText: obscureText,
        style: const TextStyle(color: Color(0xfff7e6ff)),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade200),
          enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 2)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200)),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText; // Cambia el estado al hacer clic
              });
            },
          ),
        ),
      ),
    );
  }
}
