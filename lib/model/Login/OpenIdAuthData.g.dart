// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OpenIdAuthData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OpenIdAuthData _$OpenIdAuthDataFromJson(Map<String, dynamic> json) =>
    OpenIdAuthData(
      json['access_token'] as String,
      json['expires_in'] as int,
      json['refresh_expires_in'] as int,
      json['refresh_token'] as String,
      json['token_type'] as String,
      json['session_state'] as String,
      json['scope'] as String,
    );

Map<String, dynamic> _$OpenIdAuthDataToJson(OpenIdAuthData instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'expires_in': instance.expires_in,
      'refresh_expires_in': instance.refresh_expires_in,
      'refresh_token': instance.refresh_token,
      'token_type': instance.token_type,
      'session_state': instance.session_state,
      'scope': instance.scope,
    };
