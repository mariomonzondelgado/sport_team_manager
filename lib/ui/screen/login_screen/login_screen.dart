import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/service/auth_service.dart';
import 'package:sport_team_manager/ui/screen/register_screen/register_screen.dart';
import 'package:sport_team_manager/ui/screen/tabs_screen/tabs_screen.dart';
import 'package:sport_team_manager/util/snackbar_util.dart';
import 'package:sport_team_manager/util/string_value_util.dart';
import 'package:sport_team_manager/util/text_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final AuthService _authService = AuthService();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _loginBackgroundGradient(),
          Center(
            child: StreamBuilder(
              stream: _authService.authStatus,
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  !snapshot.hasData || snapshot.hasError
                      ? loginPage()
                      : TabsScreen(memberId: snapshot.data.uid),
            ),
          ),
        ],
      ),
    );
  }

  Container _loginBackgroundGradient() {
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

  Widget loginPage() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        height: MediaQuery.of(context).size.height * 0.5,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromRGBO(255, 255, 255, 0.6),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _emailFormField(),
                    const SizedBox(height: 16.0),
                    _passwordFormField(),
                    const Divider(color: Colors.transparent),
                    _signinButton(),
                    const Divider(color: Colors.transparent),
                    _registerTextButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _signinButton() {
    return ElevatedButton(
      onPressed: () async {
        try {
          // await Person.signIn(_emailController.text,_passwordController.text);
          await _authService.signin(
              _emailController.text, _passwordController.text);
        } on FirebaseAuthException catch (e) {
          showErrorMessage(context, e.code);
          // ControllerToastMessages.messageFromError(e.toString());
        }
      },
      child: const Text(sign_in),
    );
  }

  TextFormField _passwordFormField() {
    return TextFormField(
      controller: _passwordController,
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your password',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

  TextFormField _emailFormField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Enter your email',
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (value.isEmail()) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  TextButton _registerTextButton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegisterScreen()));
      },
      child: const Text(register_here),
    );
  }
}
