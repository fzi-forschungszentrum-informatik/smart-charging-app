import 'package:json_annotation/json_annotation.dart';



part 'meteringValue.g.dart';

@JsonSerializable()
class MeteringValue {

  DateTime date;
  double value;
  String unit;
  MeteringValue(
      this.date, this.value, this.unit) ;

  factory MeteringValue.fromJson(Map<String, dynamic> json) => _$MeteringValueFromJson(json);


  Map<String, dynamic> toJson() => _$MeteringValueToJson(this);
}
