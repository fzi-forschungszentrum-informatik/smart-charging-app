import 'package:flutter/material.dart';
import '../../../layouts/themes/themeDefs/const_settings.dart';
import '../../../model/ChargePoint/chargePoint.dart';

class SiteTileWidget extends StatefulWidget {
  SiteTileWidget({
    required this.site,
    required this.selectedConnector,
    required this.newConnectorSelected,
  });

  ChargePoint site;
  int selectedConnector;
  Function newConnectorSelected;


  @override
  _SiteTileWidgetState createState() => _SiteTileWidgetState();
}

class _SiteTileWidgetState extends State<SiteTileWidget> {

  Widget buildConnectorTiles(ChargePoint site) {
 return   Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              widget.newConnectorSelected(site.chargePointId);
            },
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                       site.name,
                        style: kSettingsWidgetSubtitleTextStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (site.maximumPower * 0.001).toString() +
                            ' kW',
                        style: kSettingsWidgetSubtitleTextStyle,
                      ),
                      Text(
                        'Ladeleistung',
                        style: kSettingsInformationTextStyle,
                      ),
                    ],
                  ),
                ),
                Icon(Icons.check,
                    color: site.chargePointId == widget.selectedConnector
                        ? Colors.black87
                        : Colors.white),
              ],
            ),
          ),
        );//);



  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              flex: (kFlexFactor + 1),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(vertical: 6.0),
                child: Column(
                  children: [
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          flex: kFlexFactor,
                          child: Column(
                            children:[
                            buildConnectorTiles(
                                widget.site)],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    SizedBox(
                        height: 0.5,
                        child:
                        Container(color: Colors.black54)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}