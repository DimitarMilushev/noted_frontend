import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum()
enum UserRole {
  @JsonValue("USER")
  user("USER"),
  @JsonValue("ADMIN")
  admin("ADMIN");

  const UserRole(this.value);
  final String value;
}
