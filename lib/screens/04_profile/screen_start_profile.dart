import 'package:flutter/material.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_my_charging_stations.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_my_vehicles.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/header_settings.dart';
import '../../layouts/mainLayout.dart';
import '../../layouts/themes/themeDefs/const_settings.dart';
import '../../model/UserProfile/userProfile.dart';
import 'package:provider/provider.dart';
import '../../providers/UserService.dart';
import '../../providers/globalDataStore.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = "SettingsScreen";


  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
   UserProfile? accountProfile;
   bool isLoading = false;
   late Future getDataFuture;

   Future<void> buildDataFuture(bool reload) async{
     GlobalDataStore store = Provider.of<GlobalDataStore>(this.context, listen: false );

     if(store.profile==null || reload){
       GlobalDataStore store = Provider.of<GlobalDataStore>(this.context, listen: false );
       UserService service = Provider.of<UserService>(this.context, listen: false );
       await service.getUserProfile().then((value) => setState(()=>{accountProfile = value, store.profile = value}));

     }
     else{
       setState(() {
         this.accountProfile = store.profile!;
       });
     }
   }

  @override
  void initState(){
    super.initState();


  }

  reloadData(){
    getDataFuture = buildDataFuture(true);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if(accountProfile == null) return MainLayout(child: Container());
    getDataFuture = buildDataFuture(false);
    return MainLayout(id: SettingsScreen.id,child:
    FutureBuilder<void>(
    future: getDataFuture, // async work
    builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.waiting: return Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
            crossAxisAlignment : CrossAxisAlignment.center,children:kSnapshotIsNotDoneYet));
        default:
          if (snapshot.hasError)
            return  Center(child:Column(    mainAxisAlignment : MainAxisAlignment.center,
                crossAxisAlignment : CrossAxisAlignment.center,children: kSnapshotHasError));

    return Column(
      children: [
          SettingsHeader(account: accountProfile!),

          Expanded(
            child: ListView(
              children: [
                MyVehiclesWidget(
                    account: accountProfile!, reloadData: reloadData,
                ),
                MyChargingStationsWidget(
                    account: accountProfile!
                  // backend: widget.backend,
                ),
              ],
            ),
          ),
        ],
    );
  }}));
}}
