import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:fzi_charging_app/local/config.dart';
import 'package:fzi_charging_app/model/Login/OpenIdAuthData.dart';
import 'package:fzi_charging_app/providers/UserService.dart';
import 'package:fzi_charging_app/providers/chargingService.dart';
import 'package:fzi_charging_app/providers/globalDataStore.dart';
import 'package:fzi_charging_app/providers/meteringService.dart';
import 'package:fzi_charging_app/providers/screenIndexProvider.dart';
import 'package:fzi_charging_app/repositories/chargeHistoryRepository.dart';
import 'package:fzi_charging_app/repositories/chargingRepository.dart';
import 'package:fzi_charging_app/repositories/meteringRepository.dart';
import 'package:fzi_charging_app/repositories/userProfileRepository.dart';
import 'package:fzi_charging_app/screens/00_userSetup/screen_welcome.dart';
import 'package:fzi_charging_app/screens/02_diary/screen_start_diary.dart';
import 'package:fzi_charging_app/screens/03_household/screen_start_household.dart';
import 'package:fzi_charging_app/screens/04_profile/screen_start_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/01_charging/screen_start_charging.dart';
import 'package:provider/provider.dart';
import 'layouts/themes/appThemes.dart';
import 'package:fzi_charging_app/providers/chargeHistoryService.dart';

class App extends StatefulWidget {
  SharedPreferences? prefs;
  App(this.prefs);

  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {

  String appBaseUrl = ConfigValues.BackendApiUrl;
  @override
  Widget build(BuildContext context) {


    return MultiProvider( child: MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Charging App',
    theme: AppThemes.defaultTheme,
    home: isAuth() ? ChargingScreen() : WelcomeScreen() ,
    routes: {
    WelcomeScreen.id: (context) => WelcomeScreen(),
    HausanschlussScreen.id: (context) =>  isAuth() ? HausanschlussScreen() : WelcomeScreen(),
    TagebuchScreen.id: (context) => isAuth() ?TagebuchScreen(): WelcomeScreen(),
    SettingsScreen.id: (context) => isAuth() ?SettingsScreen(): WelcomeScreen(),
    ChargingScreen.id: (context) => isAuth() ?ChargingScreen(): WelcomeScreen()}), providers: [
        ChangeNotifierProvider(create: (context) => screenIndexProvider()),
      Provider<ChargeHistoryRepository>(create: (context) => new ChargeHistoryRepository(appBaseUrl)),
      Provider<ChargeHistoryService>(create: (context)=> new ChargeHistoryService(context)),
    Provider<ChargingRepository>(create: (context)=> new ChargingRepository(appBaseUrl)),
    Provider<ChargingService>(create: (context)=> new ChargingService(context)),
      Provider<UserProfileRepository>(create: (context) => new UserProfileRepository(appBaseUrl)),
      Provider<UserService>(create: (context)=> new UserService(context)),
      Provider<MeteringRepository>(create: (context) => new MeteringRepository(appBaseUrl)),
      Provider<MeteringService>(create: (context)=> new MeteringService(context)),
      Provider<GlobalDataStore>(create: (context)=> new GlobalDataStore()),





    ]);
  }

  bool isAuth(){
    if(!ConfigValues.UseKeyCloakAuth) return true; // bypass auth for debug
    OpenIdAuthData? authData;
    String? authDataString = widget.prefs!.getString("OpenIdAuthData");
    if(authDataString != null) {
      authData = OpenIdAuthData.fromJson(jsonDecode(authDataString!));
    }
    bool isAuth = authData != null && !JwtDecoder.isExpired(authData!.access_token);
    return isAuth;
  }




}