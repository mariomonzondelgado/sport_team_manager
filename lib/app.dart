import 'package:flutter/material.dart';
import 'package:sport_team_manager/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App title',
      initialRoute: '/splash_screen',
      routes: routeMap,
    );
  }
}
