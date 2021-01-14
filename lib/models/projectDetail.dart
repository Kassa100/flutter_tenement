import 'package:json_annotation/json_annotation.dart';

part 'projectDetail.g.dart';

@JsonSerializable()
class ProjectDetail {
    ProjectDetail();

    String msg;
    Map<String,dynamic> data;
    
    factory ProjectDetail.fromJson(Map<String,dynamic> json) => _$ProjectDetailFromJson(json);
    Map<String, dynamic> toJson() => _$ProjectDetailToJson(this);
}
