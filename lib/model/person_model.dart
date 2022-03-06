import 'package:firebase_auth/firebase_auth.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sport_team_manager/service/auth_service.dart';
import 'package:sport_team_manager/service/database.dart';
import 'package:sport_team_manager/util/string_value_util.dart';
import 'package:sport_team_manager/util/text_utils.dart';

part 'person_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Person {
  Person({
    required this.firstName,
    required this.lastName,
    required this.email,
  }) : isAdmin = false;

  Person.fromDB({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.isAdmin,
  });

  @JsonKey(name: 'firstName')
  String firstName;

  @JsonKey(name: 'lastName')
  String lastName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'isAdmin')
  bool isAdmin;

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);

  static signIn(String email, String password) async {
    if (email.isEmail()) {
      throw Exception(add_valid_email);
    } else if (password.isPassword()) {
      throw Exception(add_valid_password);
    } else {
      final Database db = Database();
      bool exists = await db.checkIfUserExistsInDB(email);
      if (exists) {
        final AuthService authService = AuthService();
        authService.signin(email, password);
      } else {
        throw Exception(invalid_email_password);
      }
    }
  }

  static signUp(
      String firstName, String lastName, String email, String password) async {
    if (firstName.trim().isEmpty) {
      throw Exception(add_valid_first_name);
    } else if (lastName.trim().isEmpty) {
      throw Exception(add_valid_last_name);
    } else if (!email.isEmail()) {
      throw Exception(add_valid_email);
    } else if (!password.isPassword()) {
      throw Exception(add_valid_password);
    } else {
      final AuthService authService = AuthService();
      final Database db = Database();
      bool exists = await db.checkIfUserExistsInDB(email);
      if (exists) {
        throw Exception("El correo ya está registrado");
      } else {
        await authService.signup(email, password);
        User? user = authService.currentUser();
        Person person =
            Person(firstName: firstName, lastName: lastName, email: email);
        await db.addMember(person, user!.uid);
      }
    }
  }

  signOut() async {
    final AuthService authService = AuthService();
    await authService.signout();
  }
}
