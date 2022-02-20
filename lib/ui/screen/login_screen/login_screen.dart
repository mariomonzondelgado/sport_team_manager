import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/service/auth_service.dart';
import 'package:sport_team_manager/service/controller_toast_menssages.dart';
import 'package:sport_team_manager/ui/screen/register_screen/register_screen.dart';
import 'package:sport_team_manager/ui/screen/tabs_screen/tabs_screen.dart';
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
        body: Center(
            child: StreamBuilder(
      stream: _authService.authStatus,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
          return loginPage();
        } else {
          return TabsScreen(memberId: snapshot.data.uid);
        }
      },
    )));
  }

  Widget loginPage() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
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
                  TextFormField(
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
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
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
                  ),
                  Divider(color: Colors.transparent),
                  TextButton(
                    onPressed: () {},
                    child: Text('RECUPERAR CONTRASEÑA'),
                  ),
                  Divider(color: Colors.transparent),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        // await Person.signIn(_emailController.text,_passwordController.text);
                        await _authService.signin(
                            _emailController.text, _passwordController.text);
                      } catch (e) {
                        ControllerToastMessages.messageFromError(e.toString());
                      }
                    },
                    child: Text('sign in'),
                  ),
                  Divider(color: Colors.transparent),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterScreen()));
                    },
                    child: Text('¿No tienes cuenta? Regístrate aquí.'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
