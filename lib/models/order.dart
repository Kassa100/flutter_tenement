import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
    Order();

    String msg;
    List list;
    
    factory Order.fromJson(Map<String,dynamic> json) => _$OrderFromJson(json);
    Map<String, dynamic> toJson() => _$OrderToJson(this);
}
