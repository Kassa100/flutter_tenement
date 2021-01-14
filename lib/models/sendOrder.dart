import 'package:json_annotation/json_annotation.dart';

part 'sendOrder.g.dart';

@JsonSerializable()
class SendOrder {
    SendOrder();

    String msg;
    
    factory SendOrder.fromJson(Map<String,dynamic> json) => _$SendOrderFromJson(json);
    Map<String, dynamic> toJson() => _$SendOrderToJson(this);
}
