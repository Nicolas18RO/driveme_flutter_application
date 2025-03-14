import 'package:flutter/material.dart';

class Text_Continua_Con extends StatelessWidget {
  const Text_Continua_Con({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color(0xfff7e6ff),
            ),
          ),
          Text(
            "O continua con",
            style: TextStyle(
              color: Color(0xfff7e6ff),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Color(0xfff7e6ff),
            ),
          )
        ],
      ),
    );
  }
}
