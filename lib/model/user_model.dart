import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String uid;
  String email;
  String firstName;
  String secondName;
  String role;

  UserModel(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.secondName,
      required this.role});

  // receiving data from server
  factory UserModel.fromMap(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  // sending data to our server
  Map<String, dynamic> toMap() => _$UserModelToJson(this);

  //Reference: https://docs.flutter.dev/development/data-and-backend/json
}
