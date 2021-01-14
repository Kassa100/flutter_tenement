import 'package:json_annotation/json_annotation.dart';

part 'sendCollection.g.dart';

@JsonSerializable()
class SendCollection {
    SendCollection();

    String msg;
    
    factory SendCollection.fromJson(Map<String,dynamic> json) => _$SendCollectionFromJson(json);
    Map<String, dynamic> toJson() => _$SendCollectionToJson(this);
}
