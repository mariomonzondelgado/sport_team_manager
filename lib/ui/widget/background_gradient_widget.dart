import 'package:flutter/material.dart';

class BackgroundGradientWidget extends StatelessWidget {
  const BackgroundGradientWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber[700]!,
            Colors.amber[500]!,
            Colors.amber[300]!,
            Colors.amber[100]!,
          ],
        ),
      ),
    );
  }
}
