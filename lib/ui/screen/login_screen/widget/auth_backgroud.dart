import 'package:flutter/material.dart';
import 'package:sport_team_manager/util/assets_utils.dart';

class AuthBackgroud extends StatelessWidget {
  const AuthBackgroud({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _GradientBackgroundBox(),
          _HeaderLogo(),
          this.child,
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
      child: Stack(
        children: const [
          Positioned(child: _Bubble(), top: 90, left: 30),
          Positioned(child: _Bubble(), top: -40, left: -30),
          Positioned(child: _Bubble(), top: -50, right: -20),
          Positioned(child: _Bubble(), bottom: -50, left: 10),
          Positioned(child: _Bubble(), bottom: 120, right: 20),
          Positioned(child: _Bubble(), bottom: 70, right: 160),
        ],
      ),
    );
  }

  BoxDecoration _yellowGradient() => const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(255, 190, 0, 1),
        Color.fromRGBO(253, 209, 104, 1.0),
      ]));
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: const Color.fromRGBO(255, 255, 255, 0.1),
      ),
    );
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10.0),
        child: Image.asset(
          Res.imagesLogoCanes,
          height: 200.0,
        ),
      ),
    );
  }
}
