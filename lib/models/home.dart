import 'package:json_annotation/json_annotation.dart';

part 'home.g.dart';

@JsonSerializable()
class Home {
    Home();

    String banner;
    String banner_text;
    List icons;
    List region;
    List apart;
    List flats;
    
    factory Home.fromJson(Map<String,dynamic> json) => _$HomeFromJson(json);
    Map<String, dynamic> toJson() => _$HomeToJson(this);
}
