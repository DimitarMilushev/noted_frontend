import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign-in.dto.freezed.dart';
part 'sign-in.dto.g.dart';

@freezed
class SignInDto with _$SignInDto {
  const factory SignInDto({required String email, required String password}) =
      _SignInDto;

  factory SignInDto.fromJson(Map<String, dynamic> json) => _$SignInDtoFromJson(json);
}