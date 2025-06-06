import 'dart:ui';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: CircleAvatar(
        minRadius: 70,
        backgroundImage: AssetImage(
          'lib/Images/LogoDM.png',
        ),
      ),
    );
  }
}

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

class ContainerBlur extends StatelessWidget {
  final double widthContainerBlur;
  final double heigthContainerBlur;
  final Widget child;

  const ContainerBlur({
    super.key,
    required this.child,
    required this.widthContainerBlur,
    required this.heigthContainerBlur,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: SizedBox(
          width: widthContainerBlur, //300
          height: heigthContainerBlur, //480
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(40),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
            Color(0xff740f80),
            Color(0xFFBD11DF),
            Color(0xFFEB6AFF),
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
      ),
    );
  }
}

class ContainerBackground extends StatelessWidget {
  const ContainerBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: 250,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: <Color>[
            Color(0xFFF90909),
            Color(0xFFFF5B5B),
            Color(0xFFFFDEDE)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}
