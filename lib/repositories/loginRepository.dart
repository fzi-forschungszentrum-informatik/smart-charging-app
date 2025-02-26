
import 'package:dio/dio.dart';
import 'package:fzi_charging_app/model/Login/OpenIdAuthData.dart';

import '../providers/backendClient.dart';

class LoginRepository extends BackendClient{
  LoginRepository(super.baseUrl,super.useBearer);

  Future<OpenIdAuthData> getLoginData(String username, String password){
    var formData = {
      'client_id': 'sample-flutter',
      'username': username,
      "password": password,
      "grant_type": 'password'

    };
    return this.post<OpenIdAuthData>("/realms/master/protocol/openid-connect/token", formData , (data) => OpenIdAuthData.fromJson(data), Options(contentType: Headers.formUrlEncodedContentType));
  }


}