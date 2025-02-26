//Comment out due to licence requirements.
// Please make sure you have a correct syncfusion license.
//More Information at: https://pub.dev/packages/syncfusion_flutter_charts/license
/*
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../model/Metering/meteringChartData.dart';


class SyncLineChart extends StatefulWidget {
  SyncLineChart(this.chartSeries, this.setUpdate);
  List<MeteringChartData> chartSeries;
  Function setUpdate;

  @override
  _SyncLineChartState createState() => _SyncLineChartState();
}


class _SyncLineChartState extends State<SyncLineChart> {


  Map<String, ChartSeriesController> chartSeriesControllerMap = HashMap();
  Map<String, List<MapEntry<DateTime, double>>> dataList = HashMap();

  ChartSeries getFromData(MeteringChartData data){
    return StepLineSeries<MapEntry<DateTime, double>, DateTime>(
        name: data.name,
        markerSettings:
        MarkerSettings(isVisible: true, height: 4, width: 4),
        color: data.getColor(),
        yAxisName: data.yAxisName,
        onRendererCreated: (ChartSeriesController controller) {
          chartSeriesControllerMap[data.name] = controller;
        },
        dataSource: dataList[data.name]!,
        xValueMapper: (MapEntry<DateTime, double> entry, _) => entry.key,
        yValueMapper: (MapEntry<DateTime, double> entry,_) => entry.value);
  }

  void updateData(List<MeteringChartData> dataList){
    widget.chartSeries = dataList;
    dataList.forEach((element) {updateDataLines(element.name);});
  }

  void updateDataLines(String name){
    MeteringChartData matchingData = widget.chartSeries.firstWhere((element) => element.name == name);
    DateTime lastDate = dataList[name]!.last.key;
    List<MapEntry<DateTime, double>> newData = matchingData.seriesData.entries.where((element) => element.key.isAfter(lastDate)).toList();
    print("Found ${newData.length} items to add for $name, last DateTime was $lastDate, last newData was ${matchingData.seriesData.entries.last.key}");
    int oldLastIdx = dataList[name]!.length-1;
    dataList[name]!.addAll(newData);
    List<int> indexList = List.empty(growable: true);
    for(int i = oldLastIdx; i<oldLastIdx+newData.length;i++ ){
      indexList.add(i);
    }
    print("update " + name);
    chartSeriesControllerMap[name]?.updateDataSource(
      addedDataIndexes: indexList,
    );

  }

  List<ChartSeries> buildSeriesList(List<MeteringChartData> data){
    chartSeriesControllerMap.clear();
    List<ChartSeries> series = List.empty(growable:true);
    data.forEach((element) {
      dataList[element.name] = element.seriesData.entries.toList();
      series.add(getFromData(element));

    });
    return series;
  }
  @override
  void initState() {
    widget.setUpdate(updateData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: SfCartesianChart(

            legend: Legend(
                isVisible: true,
                position: LegendPosition.bottom,
                toggleSeriesVisibility: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            zoomPanBehavior: ZoomPanBehavior(
                enablePinching: true,
                enableSelectionZooming: true,

                enableDoubleTapZooming: true,
                enablePanning: true,
                zoomMode: ZoomMode.x),
            enableAxisAnimation: false,
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat("dd/MM - HH:mm 'Uhr'"),
            ),
            primaryYAxis: NumericAxis(
              anchorRangeToVisiblePoints: false,
              numberFormat: NumberFormat("##### kW"),
              name: 'kW',
            ),
            axes: <ChartAxis>[
              NumericAxis(
                numberFormat: NumberFormat("### ct/kWh"),
                anchorRangeToVisiblePoints: false,
                maximumLabels: 1,
                name: 'ct/kWh',
                opposedPosition: true,
              )
            ],
            series: buildSeriesList(widget.chartSeries)
            /* <ChartSeries>[
              StepLineSeries<MapEntry<DateTime, double>, DateTime>(
                  name: 'Lastgrenze',
                  markerSettings:
                      MarkerSettings(isVisible: true, height: 4, width: 4),
                  color: Color.fromRGBO(75, 135, 185, 1),
                  dataSource: List.of(widget.dataList1.entries),
                  xValueMapper: (MapEntry entry, _) => entry.key,
                  yValueMapper: (MapEntry entry, _) => entry.value),
              StepLineSeries<MapEntry<DateTime, double>, DateTime>(
                  yAxisName: 'ct/kWh',
                  markerSettings:
                      MarkerSettings(isVisible: true, height: 4, width: 4),
                  name: 'Preise',
                  color: Color.fromRGBO(192, 108, 132, 1),
                  dataSource: List.of(widget.dataList2.entries),
                  xValueMapper: (MapEntry entry, _) => entry.key,
                  yValueMapper: (MapEntry entry, _) => entry.value),
              StepLineSeries<MapEntry<DateTime, double>, DateTime>(
                  markerSettings:
                      MarkerSettings(isVisible: true, height: 4, width: 4),
                  name: 'Tesla',
                  color: Color.fromRGBO(192, 190, 132, 1),
                  dataSource: List.of(widget.dataList3.entries),
                  xValueMapper: (MapEntry entry, _) => entry.key,
                  yValueMapper: (MapEntry entry, _) => entry.value),
            ],*/
          ),
        ),
      ),
    );
  }
}
*/