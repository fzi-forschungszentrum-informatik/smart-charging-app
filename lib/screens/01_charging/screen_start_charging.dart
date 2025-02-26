import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fzi_charging_app/layouts/mainLayout.dart';
import 'package:fzi_charging_app/model/ChargePoint/chargePriceForecast.dart';
import 'package:fzi_charging_app/providers/UserService.dart';
import 'package:fzi_charging_app/providers/chargingService.dart';
import 'package:fzi_charging_app/providers/globalDataStore.dart';
import 'package:provider/provider.dart';
import '../../model/ChargePoint/chargingTransaction.dart';
import '../../model/UserProfile/userProfile.dart';
import 'widgets/window_for_charging_plan_line_chart.dart';
import 'widgets/inputParameter/slider_departure_time.dart';
import 'widgets/inputParameter/slider_current_soc.dart';
import 'widgets/inputParameter/widget_mode_buttons.dart';
import 'widgets/inputParameter/slider_desired_soc.dart';
import 'widgets/window_charging_cost.dart';
import 'widgets/button_laden.dart';
import 'widgets/button_show_line_chart.dart';
import '../98_general/media_query.dart';
import '../../layouts/themes/themeDefs/const_settings.dart';

class ChargingScreen extends StatefulWidget {


  static const String id = "ChargingScreen";

  @override
  _ChargingScreenState createState() => _ChargingScreenState();
}


class _ChargingScreenState extends State<ChargingScreen> {
  ChargePriceForecast? forecast;
  UserProfile? profile;
  ChargingTransaction? currentTransaction;
  late Timer timer;
  late ChargingService service;

  Future<void> loadDataFuture() async{

    UserService userService = Provider.of<UserService>(context, listen: false);
    GlobalDataStore store =  Provider.of<GlobalDataStore>(context, listen: false);
    if(store.profile == null) {
     await userService.getUserProfile().then((value) =>
      {
        setState(() => this.profile = value),
        store.profile = value
      });
    }
    else{
      setState(()=>this.profile = store.profile);
    }

    ChargingService service = Provider.of<ChargingService>(this.context, listen: false);
    await service.getPriceForecast(0).then((data)=>{

      setState(()=>this.forecast = data)

    });

    await service.getRunningTransactions(this.profile!.currentSelectedChargePoint.chargePointId).then((value) => value.length >0 ? setState(()=>this.currentTransaction = value.first) : value.toList());

  }

  late Future<void> lDataF;
  @override
  void initState() {
    super.initState();
    service = Provider.of<ChargingService>(this.context, listen: false);
   lDataF = loadDataFuture();

    timer =  Timer.periodic(const Duration(seconds: 2), (timer) {
      if(currentTransaction==null) return;

      service.getTransactionState(currentTransaction!.chargePointId, currentTransaction!.transactionId).then((value) => setState(()=>this.currentTransaction = value));

    });

  }



  _addNowAndDepartureToMap(SplayTreeMap<DateTime, dynamic> map, DateTime now) {
    if (map.isNotEmpty) {
      DateTime first = map.firstKey()!;
      if (now.isBefore(first)) {
        map[now] = map[first]!;
      }
      // DateTime departure = widget.chargingParameter.getDeparture(now);
      // if (departure.isAfter(last)) {
      // map[widget.chargingParameter.getDeparture(now)] = map[last]!;
      // }
    }

      if(forecast != null && profile != null){
        Map<DateTime,double> forecastMap = forecast!.chargingPlanDictionary[profile!.chargeSettings.chargeMode]!;
        map.clear();
        forecastMap.forEach((key, value) {map[key.toLocal()] = value;});

      }
  }



  void _resetCosts(){

  }

  Future<void> _refreshCosts() async{
    try{
      UserService userService = Provider.of<UserService>(context, listen: false);
      if(profile!= null ) {
        await userService.setUserSettings(profile!.chargeSettings).then((value)=>  loadDataFuture());
      }

    }
    catch(err){
      setState(()=>error(err));//);
    }
  }

  void error(err){
    lDataF = Future.error(err);
  }

  void startCharging(){
    if(currentTransaction != null) return;
    ChargingService service = Provider.of<ChargingService>(this.context, listen: false);
    service.startChargingTransaction(this.profile!.currentSelectedChargePoint.chargePointId).then((value) => setState(()=>this.currentTransaction = value));

  }

  void stopCharging(){
    if(currentTransaction==null) return;
    ChargingService service = Provider.of<ChargingService>(this.context, listen: false);
    service.stopChargingTransaction(currentTransaction!).then((value) => setState(()=>this.currentTransaction = null));

  }

  @override
  void dispose(){
    print("dispose");
    timer.cancel();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return MainLayout(child:Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: FutureBuilder<void>(
        future: lDataF, // async work
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,children:kSnapshotIsNotDoneYet));
            default:
              if (snapshot.hasError)
                return  Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
                  crossAxisAlignment : CrossAxisAlignment.center,children: kSnapshotHasError));

                return Column(children: [
                  Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        Flexible(
                          child:  KostenView(forecast, profile?.chargeSettings.chargeMode, currentTransaction),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          child: ChargingModeSelection(
                              setState, forecast),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: MediaQueryUtils.heightIsAbove590(context) ? 10 : 7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        MediaQueryUtils.heightIsAbove590(context)
                            ? AktuellerLadestandSlider(profile,

                          _resetCosts,
                          _refreshCosts,
                        )
                            : Container(),
                        MediaQueryUtils.heightIsAbove590(context)
                            ? GewuenschterLadestandSlider(
                          profile,
                          _resetCosts,
                          _refreshCosts,
                        )
                            : Container(),
                        AbfahrtszeitSlider(

                          DateTime.now()
                          ,
                          profile,
                          _resetCosts,
                          _refreshCosts,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ChargingPlanButton(
                              height: MediaQuery.of(context).size.height * 0.06,
                              chartProvider: () {
                                DateTime now = DateTime.now();
                                SplayTreeMap<DateTime, double>
                                estimatedStateOfChargeFactor =
                                new SplayTreeMap<DateTime, double>();
                                _addNowAndDepartureToMap(
                                    estimatedStateOfChargeFactor, now);
                                return ChargingPlanLineChart(
                                  estimatedStateOfChargeFactor:
                                  estimatedStateOfChargeFactor,
                                  timeStart:
                                  DateFormat('HH:mm').format(now) + ' Uhr',
                                  timeEnd: "In Zukunft",
                                  widgetHeight: MediaQuery.of(context).size.width,
                                  widgetWidth:
                                  MediaQuery.of(context).size.width * 0.9,
                                  descriptionTimeStart: 'Jetzt',
                                  descriptionTimeEnd: 'Geplante Abfahrt',
                                );
                              },
                            ),
                            LadenButton(
                              this.currentTransaction,startCharging,stopCharging,

                              _refreshCosts,

                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]);

          }
        },
      ),
          ),
    );
  }
}

