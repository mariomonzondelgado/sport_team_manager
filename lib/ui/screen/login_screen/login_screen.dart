import 'package:flutter/material.dart';
import 'package:sport_team_manager/ui/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackgroud(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
              ),
              CardContainer(
                child: Container(), //TODO: Modificar
              ),
            ],
          ),
        ),
      ),
    );
  }
}
