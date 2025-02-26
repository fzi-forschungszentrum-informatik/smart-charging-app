import 'package:flutter/material.dart';
import 'package:fzi_charging_app/providers/UserService.dart';
import 'package:provider/provider.dart';
import '../../../../model/UserProfile/userProfile.dart';
import '../../../../model/chargingMode.dart';
import '../../../../providers/globalDataStore.dart';
import '../../../98_general/media_query.dart';
import 'widget_mode_single_button.dart';
import 'package:fzi_charging_app/model/ChargePoint/chargePriceForecast.dart';

class ChargingModeSelection extends StatefulWidget {
  ChargingModeSelection(
    this.parentSetState,
      this.forecast
  );


  final Function parentSetState;
  final ChargePriceForecast? forecast;

  @override
  _ChargingModeSelectionState createState() => _ChargingModeSelectionState();
}

class _ChargingModeSelectionState extends State<ChargingModeSelection> {

  UserProfile? profile;

  getPriceDifference(ChargingMode charginMode) {
    UserProfile? profile  = Provider.of<GlobalDataStore>(this.context, listen: false).profile;
    if(profile == null || widget.forecast == null || !widget.forecast!.priceDictionary.containsKey(charginMode)) return 0;
    return (widget.forecast!.priceDictionary[charginMode]! - widget.forecast!.priceDictionary[profile.chargeSettings.chargeMode]!);
    //if(widget.expectedCosts == null || !widget.expectedCosts.containsKey(charginMode)) return 0;
    //return (widget.expectedCosts[charginMode]! - widget.expectedCosts[widget.chargingParameter.mode]!);
  }

  setChargingMode(ChargingMode mode){
    UserService service = Provider.of<UserService>(this.context, listen: false);
    if(profile != null){
      profile!.chargeSettings.chargeMode = mode;
      service.setUserSettings(profile!.chargeSettings);
    }
  }

  bool isSelectedChargingMode(ChargingMode mode, bool def){
    if(profile != null) return profile!.chargeSettings.chargeMode == mode;
    return def;
  }

  @override
  Widget build(BuildContext context) {
     profile  = Provider.of<GlobalDataStore>(this.context, listen: false).profile;

    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'LADEMODUS',
                style: TextStyle(
                    fontSize:
                        MediaQueryUtils.widthIsAbove350(context) ? 15 : 11),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => widget.parentSetState(
                () => setChargingMode(ChargingMode.OPTIMAL),
              ),
              child: ChargingModeChip(
                titel: 'Optimiert',
                description: 'Kosten senken, Grünstromanteil erhöhen',
                priceDifference: getPriceDifference(ChargingMode.OPTIMAL),
                icon_selected: Icons.eco,
                icon_default: Icons.eco_outlined,
                selected: isSelectedChargingMode(ChargingMode.OPTIMAL, true),
              ),
            ),
            GestureDetector(
              onTap: () => widget.parentSetState(
                () => setChargingMode(ChargingMode.INTELLIGENT),
              ),
              child: ChargingModeChip(
                titel: 'Intelligent',
                description:
                    'schnell bis ${profile != null ? profile!.currentSelectedVehicle.immediateChargeTargetStateOfChargeFactor : 0}% laden, danach optimiert laden',//${widget.configData.immediateChargeTargetStateOfChargeInPercent}
                priceDifference: getPriceDifference(ChargingMode.INTELLIGENT),
                icon_selected: Icons.auto_fix_high,
                icon_default: Icons.auto_fix_normal,
                selected:
                isSelectedChargingMode(ChargingMode.INTELLIGENT, false),
              ),
            ),
            GestureDetector(
              onTap: () => widget.parentSetState(
                () => setChargingMode(ChargingMode.FAST),
              ),
              child: ChargingModeChip(
                titel: 'Schnell',
                description: 'Ladestand möglichst bald erreichen',
                priceDifference: getPriceDifference(ChargingMode.FAST),
                icon_selected: Icons.fast_forward,
                icon_default: Icons.fast_forward_outlined,
                selected: isSelectedChargingMode(ChargingMode.FAST, false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
