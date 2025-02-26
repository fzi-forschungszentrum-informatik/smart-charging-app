import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/Login/OpenIdAuthData.dart';
class BackendClient{

  final Dio dio;
  bool? useBearer;

  BackendClient(String baseUrl,[bool? useBearer])
      : dio = Dio(BaseOptions(baseUrl: baseUrl, headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  })){
    this.useBearer = useBearer;

  }

  Future<void> setBearer() async {
      if(useBearer != null && !useBearer!)return;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authData = prefs.getString("OpenIdAuthData");
      if(authData == null) {print("error decoding auth data");return Future.value(null);}
      var auth =  OpenIdAuthData.fromJson(jsonDecode(authData!));
    String? bearerToken = auth.access_token;
    print("read from prefs:: " + bearerToken);
    dio.options.headers["Authorization"] = "Bearer " + ((bearerToken==null)? "" : bearerToken!);
  }

  Future<T> get<T>(String path, T Function(dynamic)  x) async{
   await setBearer();
    return dio.get(path).then((response) {
      return x(response.data);
    });
  }


  Future<T> post<T>(String path, dynamic postData, T Function(dynamic)  x,[Options? options]) async {
    await setBearer();
    return dio.post(path, data: postData,options: options).then((response) {
      return x(response.data);
    });
  }

  Future<T> put<T>(String path, dynamic putData, T Function(dynamic)  x) async {
    await setBearer();
    return dio.put(path, data: putData).then((response) {
      return x(response.data);
    });
  }

  Future<T> delete<T>(String path, T Function(dynamic)  x) async {
    await setBearer();
    return dio.delete(path).then((response) {
      return x(response.data);
    });
  }

   List<T> fromJsonList<T>(List<dynamic> json,T Function(dynamic)  x) {
    return json.map((e) => x(json)).toList();

  }
}