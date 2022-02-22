import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sport_team_manager/generated/assets.dart';
import 'package:sport_team_manager/ui/widget/background_gradient_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4),
        () => Navigator.of(context).pushReplacementNamed('/login_screen'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundGradientWidget(),
          Center(
            child: Lottie.asset(Assets.lottieKickOff),
          ),
        ],
      ),
    );
  }
}
