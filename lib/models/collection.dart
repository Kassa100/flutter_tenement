import 'package:json_annotation/json_annotation.dart';

part 'collection.g.dart';

@JsonSerializable()
class Collection {
    Collection();

    String msg;
    List list;
    
    factory Collection.fromJson(Map<String,dynamic> json) => _$CollectionFromJson(json);
    Map<String, dynamic> toJson() => _$CollectionToJson(this);
}
