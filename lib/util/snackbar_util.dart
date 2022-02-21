import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sport_team_manager/util/string_value_util.dart';

void showErrorMessage(BuildContext context, String error) {
  String message;

  switch (error) {
    case 'wrong-password':
      message = wrong_password;
      break;
    case 'invalid-email':
      message = invalid_email;
      break;
    case 'user-not-found':
      message = user_not_found;
      break;
    case 'weak-password':
      message = weak_password;
      break;
    case 'email-already-in-use':
      message = email_already_in_use;
      break;
    default:
      message = general_error;
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.roboto(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
