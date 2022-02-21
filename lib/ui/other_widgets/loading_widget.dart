import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  _LoadingWidget createState() => _LoadingWidget();
}

class _LoadingWidget extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.greenAccent),
        ),
      ),
      color: Colors.white.withOpacity(0.8),
    );
  }
}
