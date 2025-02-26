import 'package:json_annotation/json_annotation.dart';

import '../chargingMode.dart';



part 'chargePriceForecast.g.dart';

@JsonSerializable()
class ChargePriceForecast {

  final Map<ChargingMode,double> priceDictionary;
  final Map<ChargingMode,double> energyDictionary;
  final Map<ChargingMode,Map<DateTime,double>> chargingPlanDictionary;

  ChargePriceForecast(
      this. priceDictionary, this.chargingPlanDictionary, this.energyDictionary) ;

  factory ChargePriceForecast.fromJson(Map<String, dynamic> json) => _$ChargePriceForecastFromJson(json);


  Map<String, dynamic> toJson() => _$ChargePriceForecastToJson(this);
}
