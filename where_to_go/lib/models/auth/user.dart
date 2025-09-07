import "package:freezed_annotation/freezed_annotation.dart";

part "user.freezed.dart";
part "user.g.dart";

@freezed
abstract class User with _$User {
  factory User({required String email, required String password}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
