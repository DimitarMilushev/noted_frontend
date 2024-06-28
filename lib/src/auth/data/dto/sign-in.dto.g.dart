// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign-in.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SignInDtoImpl _$$SignInDtoImplFromJson(Map<String, dynamic> json) =>
    _$SignInDtoImpl(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$$SignInDtoImplToJson(_$SignInDtoImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };
