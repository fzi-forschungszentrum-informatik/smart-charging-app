import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';






part 'meteringChartData.g.dart';

@JsonSerializable()
class MeteringChartData {

  final int color;
  final Map<DateTime,double> seriesData;
  final String name;
  final String yAxisName;


  MeteringChartData(
      this.color, this.seriesData, this.name,this.yAxisName) ;

  factory MeteringChartData.fromJson(Map<String, dynamic> json) => _$MeteringChartDataFromJson(json);

  static List<MeteringChartData> fromJsonList(List<dynamic> json) {
    return json.map((e) => _$MeteringChartDataFromJson(e)).toList();
  }

  Color getColor(){
    return Color(color);
  }


  Map<String, dynamic> toJson() => _$MeteringChartDataToJson(this);
}
