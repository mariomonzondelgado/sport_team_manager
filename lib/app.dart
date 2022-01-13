import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/login_screen/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: LoginScreen(),
    );
  }
}
