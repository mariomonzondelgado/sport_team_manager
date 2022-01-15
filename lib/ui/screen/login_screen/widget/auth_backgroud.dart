import 'package:flutter/material.dart';

class AuthBackgroud extends StatelessWidget {
  const AuthBackgroud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _GradientBackgroundBox(),
        ],
      ),
    );
  }
}

class _GradientBackgroundBox extends StatelessWidget {
  const _GradientBackgroundBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      decoration: _yellowGradient(),
    );
  }

  BoxDecoration _yellowGradient() => BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(255, 190, 0, 1),
        Color.fromRGBO(255, 190, 0, 1),
      ]));
}
