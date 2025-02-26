import 'package:flutter/material.dart';
import 'package:fzi_charging_app/model/ChargePoint/chargingTransaction.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';
import 'package:fzi_charging_app/providers/globalDataStore.dart';
import 'package:provider/provider.dart';
import '../../../model/ChargePoint/chargePriceForecast.dart';
import '../../../model/UserProfile/userProfile.dart';
import '../../../model/chargingMode.dart';
import '../../98_general/media_query.dart';
import '../../../utils/number_formatting.dart';



class KostenView extends StatefulWidget {
  KostenView(
    this.forecast,
      this.mode,
      this.transaction
  );

  ChargePriceForecast? forecast;
  ChargingMode? mode;
  ChargingTransaction? transaction;


  @override
  _KostenViewState createState() => _KostenViewState();
}

class _KostenViewState extends State<KostenView> {

 ChargingMode defaultMode  = ChargingMode.INTELLIGENT;
  Curve animationCurve = Curves.easeInOut;
  Duration animationDuration = Duration(milliseconds: 350);

  bool car_connection = true;
  bool ev_station_connection = true;

  @override
  Widget build(BuildContext context) {
    UserProfile? profile  = Provider.of<GlobalDataStore>(this.context, listen: false ).profile;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: kBackgroundColorLight,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    profile != null
                                ? buildStatusWidget(
                                    ev_station_connection,
                                    ev_station_connection
                                        ? Icons.ev_station
                                        : Icons.ev_station_outlined,
                                   profile.currentSelectedChargePoint.name,
                                  )
                                : Container(),
                    profile != null
                                ? buildStatusWidget(
                                    car_connection,
                                    car_connection
                                        ? Icons.electric_car
                                        : Icons.electric_car_outlined,
                                   profile.currentSelectedVehicle.vehicleName,
                                  )
                                : Container(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(20)),
                color: kBackgroundColorLight,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: kBackgroundColorDark,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 14.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Aktueller Ladevorgang',
                            style: kKosten17pt,
                          ),
                        ],
                      ),
                      buildRowWithValues(
                          'Kosten',
                          NumberFormatters.regEuroFormatter
                              .format(widget.transaction != null ? widget.transaction!.currentChargingPrice : 0), //costs so far
                          NumberFormatters.regEuroFormatter.format(
                             widget.forecast != null && widget.mode != null  ?  widget.forecast!.priceDictionary[widget.mode] : 0),
                          'insgesamt geschätzt'),
                      buildRowWithValues(
                          'Energiemenge',
                          NumberFormatters.kwhFormatter
                              .format(widget.transaction != null ? widget.transaction!.currentChargingEnergy : 0),
                          NumberFormatters.kwhFormatter
                              .format(  widget.forecast != null && widget.mode != null  ?  widget.forecast!.energyDictionary[widget.mode] : 0),
                          'insgesamt geplant'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column buildRowWithValues(
      String title, String insNow, String shouldBe, String secondSubtitle) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                flex: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child:
                                Text(title.toUpperCase(), style: kKosten12pt))),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                )),
            Expanded(
                flex: 3,
                child: Text(
                  insNow.toString(),
                  style: kKosten14pt,
                )),
            Expanded(
                flex: 4,
                child: Text(
                  shouldBe.toString(),
                  style: kKosten17pt,
                )),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 4, child: Container()),
            Expanded(
                flex: 3,
                child: Text(
                  'bisherig',
                  style: kKosten10pt,
                )),
            Expanded(
                flex: 4,
                child: Text(
                  secondSubtitle,
                  style: kKosten10pt,
                )),
          ],
        ),
      ],
    );
  }

  Expanded buildStatusWidget(
      bool connectionStatus, IconData icon, String name) {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                  MediaQueryUtils.heightIsAbove720(context) &&
                          MediaQueryUtils.widthIsAbove350(context)
                      ? 5.0
                      : 2.0),
              child: Container(
                height: 30,
                child: FittedBox(
                  child: Icon(icon, size: 25),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    MediaQueryUtils.heightIsAbove720(context) &&
                            MediaQueryUtils.widthIsAbove350(context)
                        ? Container()
                        : buildStatusLight(connectionStatus),
                    Flexible(
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              name,
                              style: kKosten12pt,
                            ))),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                MediaQueryUtils.heightIsAbove720(context) &&
                        MediaQueryUtils.widthIsAbove350(context)
                    ? Row(
                        children: [
                          buildStatusLight(connectionStatus),
                          Flexible(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                connectionStatus ? 'Verbunden' : 'kein Signal',
                                style: kFramingTextStyle,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildStatusLight(bool connectionStatus) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: connectionStatus
              ? kConnectionStatusColorGreen
              : kConnectionStatusColorRed, // Colors.orange.shade700
          shape: BoxShape.circle),
    );
  }
}
