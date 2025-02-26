import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:fzi_charging_app/local/config.dart';
import 'package:fzi_charging_app/model/Login/OpenIdAuthData.dart';
import 'package:fzi_charging_app/repositories/loginRepository.dart';
import 'package:fzi_charging_app/screens/01_charging/screen_start_charging.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../layouts/themes/themeDefs/const_user_setup.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome';


  WelcomeScreen();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Duration get loginTime => Duration(milliseconds: 2250);
  bool fehler = false;
  OpenIdAuthData? authData;

 Future<String?> _authUser(LoginData data) async {
    var lr = LoginRepository(ConfigValues.KeyCloakBaseUrl, false);
    try{
     OpenIdAuthData auth =  await lr.getLoginData(data.name, data.password);
     authData = auth;
     print(auth.access_token);
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
     prefs.setString('OpenIdAuthData', jsonEncode(auth));

    }catch(e){
      return "die Login-Daten sind nicht korrekt!";
    }
    return null;
  }

  FormFieldValidator<String> _customPasswordValidator = (value) {
    return null;
  };

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return 'Benutzer existiert nicht';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      messages: LoginMessages(
        userHint: 'E-Mail',
        passwordHint: 'Passwort',
        confirmPasswordHint: 'Bestätigen',
        loginButton: 'Anmelden',
        signupButton: 'Registrieren',
        forgotPasswordButton: 'Passwort vergessen?',
        recoverPasswordButton: 'Hilfe',
        goBackButton: 'Zurück',
        confirmPasswordError: 'Passwörter stimmen nicht überein',
      ),
      hideForgotPasswordButton: true,
      logo: 'images/station_logo.png',
      title: 'Smart Charger',
      onLogin: _authUser,
      passwordValidator: _customPasswordValidator,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushNamed(
            ChargingScreen.id);
      },
      theme: LoginTheme(
        primaryColor: smartChargingGreen,
        titleStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.workSans().fontFamily,
        ),
      ),
    );
  }
}
