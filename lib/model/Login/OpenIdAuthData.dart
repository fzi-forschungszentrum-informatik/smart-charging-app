import 'package:json_annotation/json_annotation.dart';

part 'OpenIdAuthData.g.dart';

@JsonSerializable()
class OpenIdAuthData {

  final String access_token;
  final int expires_in;
  final int refresh_expires_in;
  final String refresh_token;
  final String token_type;
  final String session_state;
  final String scope;


  OpenIdAuthData(
      this.access_token, this.expires_in, this.refresh_expires_in, this.refresh_token, this.token_type, this.session_state, this.scope) ;

  factory OpenIdAuthData.fromJson(Map<String, dynamic> json) => _$OpenIdAuthDataFromJson(json);



  Map<String, dynamic> toJson() => _$OpenIdAuthDataToJson(this);
}
