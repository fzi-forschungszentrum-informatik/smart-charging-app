import 'package:flutter/material.dart';
import 'package:fzi_charging_app/screens/03_household/widgets/line_chart_household_load.dart';
import 'package:fzi_charging_app/screens/03_household/widgets/bar_chart_stacked.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_settings.dart';
import '../../layouts/mainLayout.dart';
import '../../layouts/themes/themeDefs/const.dart';

class HausanschlussScreen extends StatefulWidget {
   static const id = "Hausanschluss";
  @override
  _HausanschlussScreenState createState() => _HausanschlussScreenState();
}

class _HausanschlussScreenState extends State<HausanschlussScreen> {

  // Flag to activate SyncFusion line Chart for household visualisazion.
  // Keep in mind that syncfusion needs a special license to run in a production environment
  // See https://pub.dev/packages/syncfusion_flutter_charts/license for more details
 final Widget syncFusionLineChart = Container(); // to activate change to HouseholdLoadLineChart()

  Row buildPadding(Widget widget) {
    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: kFlexFactor,
          child: widget,
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {

    return MainLayout(id: HausanschlussScreen.id,child: buildPadding(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 50),
            child: Text(
              'Zuhause',
              style: kHeaderTextStyle,
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 12),
                StackedBarChart(),
                SizedBox(height: 24),
                syncFusionLineChart,
              ],
            ),
          ),
        ],
      ),
    ));
  }
}