import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign-up.dto.freezed.dart';
part 'sign-up.dto.g.dart';

@freezed
class SignUpDto with _$SignUpDto {
  const factory SignUpDto(
      {required String email,
      required String username,
      required String password}) = _SignUpDto;

  factory SignUpDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpDtoFromJson(json);
}
