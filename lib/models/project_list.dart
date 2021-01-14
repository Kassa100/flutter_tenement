import 'package:json_annotation/json_annotation.dart';

part 'project_list.g.dart';

@JsonSerializable()
class Project_list {
    Project_list();

    Map<String,dynamic> total;
    List list;
    
    factory Project_list.fromJson(Map<String,dynamic> json) => _$Project_listFromJson(json);
    Map<String, dynamic> toJson() => _$Project_listToJson(this);
}
