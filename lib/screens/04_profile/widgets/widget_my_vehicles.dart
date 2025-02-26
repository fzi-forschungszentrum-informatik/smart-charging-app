import 'package:flutter/material.dart';
import 'package:fzi_charging_app/providers/globalDataStore.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_settings_with_tiles.dart';
import 'package:provider/provider.dart';
import '../../../layouts/themes/themeDefs/const_charging_screen.dart';
import '../../../layouts/themes/themeDefs/const_settings.dart';
import '../../../model/UserProfile/userProfile.dart';
import '../../../model/UserProfile/vehicle.dart';
import '../../../providers/UserService.dart';
import '../screen_edit_vehicle.dart';
import 'widget_vehicle_tile.dart';

class MyVehiclesWidget extends StatefulWidget {

   UserProfile account;
   Function reloadData;
 MyVehiclesWidget({
    required this.account, required this.reloadData

  });

  @override
  _MyVehiclesWidgetState createState() => _MyVehiclesWidgetState();
}

class _MyVehiclesWidgetState extends State<MyVehiclesWidget> {
  List<Vehicle> vehicleList = [];
  int selectedVehicleId = 0;
  bool inEditMode = false;
  int i = 0;


  @override
  void initState() {
    super.initState();
    selectedVehicleId = widget.account.currentSelectedVehicle.vehicleId;
  }

  newVehicleSelected(int selectedVehicleId){
    setState(() {
      this.selectedVehicleId= selectedVehicleId;
    });
    UserService service = Provider.of<UserService>(context, listen: false);
    service.updateSelectedVehicle(selectedVehicleId).then((val)=>{
      service.getUserProfile().then((value) =>{
        setState(()=>widget.account = value),
         Provider.of<GlobalDataStore>(this.context,listen:false).profile = value
      })
    });

  }

  editVehicleCallback() {
    setState(() {
      inEditMode = !inEditMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children;

      children = <Widget>[
    for (var vehicle in widget.account.vehicles)
   VehicleTileWidget(
    vehicle: vehicle,
    selectedVehicleId: selectedVehicleId,
    newVehicleSelected: newVehicleSelected,
    inEditMode: inEditMode, reloadData: widget.reloadData
    )
      ];
    return SettingsWidgetWithTitle(
      title: 'MEINE FAHRZEUGE',
      icondata: Icons.electric_car,
      edit: inEditMode ? 'Fertig' : 'Bearbeiten',
      editItemsCallback: editVehicleCallback,
      widget: Column(
        children: [
          ExpandedSection(child: buildAddVehicleTile(), vertical: true, expand: inEditMode),
         Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              )
        ],
      ),
    );
  }

  onTapEdit() async{
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditVehicleScreen(vehicle:null, updateData: widget.reloadData,

            )),
      ).then((value) {
        //editVehicleCallback();
        // fetchAllVehicles();
      });
    }



  buildAddVehicleTile() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapEdit,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Container(),
          ),
          Expanded(
            flex: kFlexFactor + 1,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: kFlexFactor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fahrzeug hinzufügen',
                            style: kSettingsWidgetSubtitleTextStyle,
                          ),
                          Icon(Icons.add, color: kInteractionColor),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(height: 0.5, child: Container(color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedSection extends StatefulWidget {
  final Widget child;
  final bool expand;
  final bool vertical;
  ExpandedSection({
    this.expand = false,
    required this.vertical,
    required this.child,
  });

  @override
  _ExpandedSectionState createState() => _ExpandedSectionState();
}

class _ExpandedSectionState extends State<ExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;
  bool isDisposed = false;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  void prepareAnimations() {
    expandController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if(isDisposed) return;
    if (widget.expand) {
      if (!widget.vertical) {
        Future.delayed(Duration(milliseconds: 250),() {
          expandController.forward();
        });
      } else {
        expandController.forward();
      }
    } else {
      if (widget.vertical) {
        Future.delayed(Duration(milliseconds: 250),() {
          expandController.reverse();
        });
      } else {
        expandController.reverse();
      }
    }
  }

  @override
  void didUpdateWidget(ExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    _runExpandCheck();
  }

  @override
  void dispose() {
    isDisposed= true;
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axisAlignment: 1.0,
        sizeFactor: animation,
        axis: widget.vertical ? Axis.vertical : Axis.horizontal,
        child: widget.child);
  }
}
