

import 'package:fzi_charging_app/model/UserProfile/userProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/Login/OpenIdAuthData.dart';

class GlobalDataStore {
  //profile, vehicle, ...
  UserProfile? profile;
  OpenIdAuthData? openIdAuthData;

  GlobalDataStore(){
    getOpenIdAuthData().then((value) => openIdAuthData = value);
  }

    Future<OpenIdAuthData> getOpenIdAuthData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authData = prefs.getString("OpenIdAuthData");
    if(authData == null) return Future.error("err");
    return OpenIdAuthData.fromJson(jsonDecode(authData!));
  }

}