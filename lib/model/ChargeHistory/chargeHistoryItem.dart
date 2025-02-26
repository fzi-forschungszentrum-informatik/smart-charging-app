import 'package:json_annotation/json_annotation.dart';

part 'chargeHistoryItem.g.dart';

@JsonSerializable()
class ChargeHistoryItem {

  final String transactionId; //": "0000-0000-0000-0000-0000",

  final DateTime chargeTime;//": "2023-05-11T09:41:14.988+00:00",
  final double chargedEnergy;//": 123.5,
  final double chargingPrice;//": 45.7

  ChargeHistoryItem(
     this. transactionId, this.chargeTime,this.chargedEnergy,this.chargingPrice) ;

  factory ChargeHistoryItem.fromJson(Map<String, dynamic> json) => _$ChargeHistoryItemFromJson(json);

  static List<ChargeHistoryItem> fromJsonList(List<dynamic> json) {
    return json.map((e) => _$ChargeHistoryItemFromJson(e)).toList();

  }
 /// static List<ChargeHistoryItem> fromJsonList(List<dynamic> json) => Serializer.decode(dynamic json, _$ChargeHistoryItemFromJson)
  Map<String, dynamic> toJson() => _$ChargeHistoryItemToJson(this);
}

@JsonSerializable()
class ChargeHistoryItemList {
  List<ChargeHistoryItem> chargeHistoryList;

  ChargeHistoryItemList(this.chargeHistoryList);

  factory ChargeHistoryItemList.fromJson(Map<String, dynamic> json) => _$ChargeHistoryItemListFromJson(json);

  Map<String, dynamic> toJson() => _$ChargeHistoryItemListToJson(this);
}


