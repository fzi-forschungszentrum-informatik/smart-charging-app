import 'package:json_annotation/json_annotation.dart';



part 'chargePoint.g.dart';

@JsonSerializable()
class ChargePoint {



   int chargePointId;
   String name;
   int maximumPower;
  ChargePoint(
      this.chargePointId, this.name, this.maximumPower) ;

  factory ChargePoint.fromJson(Map<String, dynamic> json) => _$ChargePointFromJson(json);


  Map<String, dynamic> toJson() => _$ChargePointToJson(this);
}
