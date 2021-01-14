import 'package:json_annotation/json_annotation.dart';

part 'changeUser.g.dart';

@JsonSerializable()
class ChangeUser {
    ChangeUser();

    String msg;
    
    factory ChangeUser.fromJson(Map<String,dynamic> json) => _$ChangeUserFromJson(json);
    Map<String, dynamic> toJson() => _$ChangeUserToJson(this);
}
