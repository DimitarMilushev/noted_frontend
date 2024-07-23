import 'package:freezed_annotation/freezed_annotation.dart';

part 'api-exception.dto.freezed.dart';
part 'api-exception.dto.g.dart';

@freezed
class ApiExceptionDto with _$ApiExceptionDto {
  factory ApiExceptionDto({
    required Uri type,
    required String title,
    required int status,
    required String detail,
    required Uri instance,
  }) = _ApiExceptionDto;

  factory ApiExceptionDto.fromJson(Map<String, dynamic> json) =>
      _$ApiExceptionDtoFromJson(json);
}
