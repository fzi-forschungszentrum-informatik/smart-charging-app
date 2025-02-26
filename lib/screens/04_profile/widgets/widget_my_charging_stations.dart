import 'package:flutter/material.dart';
import 'package:fzi_charging_app/providers/globalDataStore.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_settings_with_tiles.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_charging_site_tile.dart';
import 'package:provider/provider.dart';
import '../../../model/UserProfile/userProfile.dart';
import '../../../providers/UserService.dart';

class MyChargingStationsWidget extends StatefulWidget {

  UserProfile account;
  MyChargingStationsWidget({
    required this.account,

  });

  @override
  _MyChargingStationsWidgetState createState() =>
      _MyChargingStationsWidgetState();
}

class _MyChargingStationsWidgetState extends State<MyChargingStationsWidget> {

 int selectedChargePointId = 0;
  @override
  void initState() {
    super.initState();

  }

  connectorSelected(int i){
      setState(()=>selectedChargePointId=i);
      UserService service = Provider.of<UserService>(this.context, listen: false);
      service.updateSelectedChargePoint(i).then((data) => {
        service.getUserProfile().then((value) => {
           Provider.of<GlobalDataStore>(context, listen: false).profile = value

        })

      });
  }



  @override
  Widget build(BuildContext context) {
    List<Widget> chargePointWidgets;

    chargePointWidgets = <Widget>[
        for (var site in widget.account.chargePoints)
          SiteTileWidget(
              site: site,
              selectedConnector: selectedChargePointId,
              newConnectorSelected: connectorSelected)

      ];

    return SettingsWidgetWithTitle(
      title: 'MEINE LADEPUNKTE',
      icondata: Icons.electrical_services,
      edit: '',
      editItemsCallback: (){},
      widget: Column(
        children:
          chargePointWidgets
        ,
      ),
    );
  }
}