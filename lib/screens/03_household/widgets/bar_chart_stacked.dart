import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fzi_charging_app/screens/98_general/general_widgets.dart';
import 'package:provider/provider.dart';
import '../../../layouts/themes/themeDefs/const_settings.dart';
import '../../../model/Metering/meteringCollection.dart';
import '../../../model/deviceType.dart';
import '../../../providers/meteringService.dart';
import '../../../utils/number_formatting.dart';

class StackedBarChart extends StatefulWidget {
  @override
  _StackedBarChartState createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {
  double iconSize = 20;
  double containerHeight = 30;
  late Widget houseloadSumWidget;
  late List<Widget> stackedBlocksListOUT = [];
  late List<Widget> stackedBlocksListIN = [];

  late List<Widget> valueIconRowOUT = [SizedBox(height: 12)];
  late List<Widget> valueIconRowIN = [SizedBox(height: 12)];

  static Map<DeviceType, IconData> _deviceTypeIconDataMap = {
    DeviceType.PV: Icons.sunny,
    DeviceType.EV: Icons.ev_station,
    DeviceType.GridConnection: Icons.electrical_services,
    DeviceType.Household: Icons.house,
    DeviceType.Unknown: Icons.power,
  };

  late Future getData;
  MeteringCollection? meterDataCollection;
  late Timer timer;

  Future<void> getDataFuture() async {
    MeteringService service =   Provider.of<MeteringService>(context, listen:false);
    await service.getMeterData().then((value) => setState(()=>meterDataCollection = value));
  }


  @override
  void initState() {
    super.initState();
    getData = getDataFuture();
    buildWidgets();
   timer =  Timer.periodic(const Duration(seconds: 2), (timer) {
      getDataFuture();

    });
  }

  @override
  void dispose(){
print("dispose");
    timer.cancel();
    super.dispose();
  }


  Expanded buildStackedBarElement(
      double value, Color color, DeviceType deviceType, double sum) {
    return Expanded(
      flex: value.abs().toInt(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.0),
        child: Container(
          height: containerHeight,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: value.abs() / sum > 0.1
              ? Icon(
                  _deviceTypeIconDataMap[deviceType],
                  size: iconSize,
                  color: Colors.white,
                )
              : Container(),
        ),
      ),
    );
  }

  Padding buildIconValueRow(DeviceType deviceType, String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(_deviceTypeIconDataMap[deviceType], size: iconSize - 2),
          SizedBox(
            width: 7,
          ),
          Text(
            title,
            style: kSettingsWidgetSubtitleTextStyle.copyWith(
                fontWeight: FontWeight.w400),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            NumberFormatters.kWFormatter.format(value),
            style: kSettingsWidgetSubtitleTextStyle.copyWith(
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  buildWidgets() {
    if(meterDataCollection==null){ print("noData");return;}
    stackedBlocksListOUT.clear();
    stackedBlocksListIN.clear();
    valueIconRowOUT = [SizedBox(height: 12)];
    valueIconRowIN = [SizedBox(height: 12)];

    double summarizedLoad = 0;

    meterDataCollection!.meteringCollection.values.forEach((device) {
      device.forEach((element) {
      if (!element.value.isNegative) summarizedLoad += element.value;
      });
    });

    houseloadSumWidget = Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(Icons.house, color: Colors.white, size: iconSize - 2),
          SizedBox(
            width: 7,
          ),
          Expanded(
            child: Column(
              children: [
                Seperator(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'Gesamt',
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      NumberFormatters.kWFormatter
                          .format(summarizedLoad / 1000),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
    int shadeIN = 500;
    int shadeOUT = 500;
    meterDataCollection!.meteringCollection.forEach((deviceType, meteringList) {
      meteringList.forEach((meteringValue) {
        if (meteringValue.value.isNegative) {
          stackedBlocksListOUT.add(
            buildStackedBarElement(
              meteringValue.value,
              Colors.orange[shadeIN]!, // Colors.green[shade]!,
              deviceType,
              summarizedLoad,
            ),
          );
          valueIconRowOUT.add(buildIconValueRow(
              deviceType,
              getNameByType(deviceType, meteringValue.value.isNegative),
              (meteringValue.value.abs() / 1000)));
          shadeIN += 100;
        } else {
          stackedBlocksListIN.add(
            buildStackedBarElement(
              meteringValue.value,
              Colors.green[shadeOUT]!,
              deviceType,
              summarizedLoad,
            ),
          );
          valueIconRowIN.add(buildIconValueRow(
              deviceType,
              getNameByType(deviceType, meteringValue.value.isNegative),
              (meteringValue.value.abs() / 1000)));
          shadeOUT += 100;
        }
      });
    });
    valueIconRowOUT.add(houseloadSumWidget);
    valueIconRowIN.add(houseloadSumWidget);

  }

  String getNameByType(DeviceType type, bool valIsNegative){
    switch(type){
      case DeviceType.EV: return "Ladepunkt";
      case DeviceType.Household: return "Haushalt";
      case DeviceType.GridConnection: return valIsNegative? "Einspeisung" :"Bezug";
      case DeviceType.PV: return "Solar";
      case DeviceType.Unknown: return "Unbekannt";
      default: return "Unbekannt";

    }
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: getData,
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting: return Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,children:kSnapshotIsNotDoneYet));
        default:
          if (snapshot.hasError)
            return  Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,children: kSnapshotHasError));
          buildWidgets();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWithIcon(icon: Icons.login, title: 'IN'),
              meterDataCollection!= null ? Container(alignment: Alignment.topRight,transform: Matrix4.translationValues(0.0, -20.0, 0.0),child:Text("Letzte Aktualisierung: ${DateFormat.Hms().format(meterDataCollection!.refreshDate.toLocal())}",textAlign: TextAlign.right)) : Container(),
          SizedBox(height: 3),Row(children: stackedBlocksListIN),
              Column(children: valueIconRowIN),
              SizedBox(height: 24),
              HeaderWithIcon(icon: Icons.logout, title: 'OUT'),
              SizedBox(height: 12),
              Row(children: stackedBlocksListOUT),
              Column(children: valueIconRowOUT),
            ],
          );
        }});
  }

}
