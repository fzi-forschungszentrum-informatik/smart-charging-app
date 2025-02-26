import 'package:json_annotation/json_annotation.dart';


import '../deviceType.dart';
import 'meteringValue.dart';




part 'meteringCollection.g.dart';

@JsonSerializable()
class MeteringCollection {

  final DateTime refreshDate;
  final Map<DeviceType,List<MeteringValue>> meteringCollection;


  MeteringCollection(
      this.refreshDate, this.meteringCollection) ;

  factory MeteringCollection.fromJson(Map<String, dynamic> json) => _$MeteringCollectionFromJson(json);


  Map<String, dynamic> toJson() => _$MeteringCollectionToJson(this);
}
