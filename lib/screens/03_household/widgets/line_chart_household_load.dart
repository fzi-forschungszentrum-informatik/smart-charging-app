//Comment out due to licence requirements.
// Please make sure you have a correct syncfusion license.
//More Information at: https://pub.dev/packages/syncfusion_flutter_charts/license
/*
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/Metering/meteringChartData.dart';
import '../../../providers/meteringService.dart';
import '../../98_general/general_widgets.dart';
import '../../98_general/line_chart_syncfusion.dart';

class HouseholdLoadLineChart extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HouseholdLoadLineChart> {

  Function? updateChart;

  List<MeteringChartData> chartSeries = List.empty();
 late  Timer timer;
  @override
  void initState() {
    MeteringService service =  Provider.of<MeteringService>(context, listen: false);
    service.getChartData().then((value) =>{ setState(()=> this.chartSeries = value)});
     timer =  Timer.periodic(const Duration(seconds: 2), (timer) {

      service.getChartData().then((value) =>{
        print("read new data"),
        this.chartSeries = value,
       if(updateChart!=null)
         updateChart!(value)
      });

    });


  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }



  Column buildLineChart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: 400,
          child:
              SyncLineChart(chartSeries, (Function x)=>{ this.updateChart = x}),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeaderWithIcon(icon: Icons.insights, title: 'VERLAUF'),
        buildLineChart(context),
      ],
    );
  }
}
*/