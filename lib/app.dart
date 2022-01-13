import 'package:flutter/material.dart';
import 'package:sport_team_manager/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App title',
      initialRoute: '/splashscreen',
      routes: routeMap,
    );
  }
}
