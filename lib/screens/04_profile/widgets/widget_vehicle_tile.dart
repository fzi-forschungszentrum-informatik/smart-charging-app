import 'package:flutter/material.dart';
import 'package:fzi_charging_app/providers/UserService.dart';
import 'package:fzi_charging_app/screens/04_profile/widgets/widget_my_vehicles.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_settings.dart';
import 'package:provider/provider.dart';
import '../../../model/UserProfile/vehicle.dart';
import '../screen_edit_vehicle.dart';

class VehicleTileWidget extends StatefulWidget {
  VehicleTileWidget(
      {required this.vehicle,
      required this.selectedVehicleId,
      required this.inEditMode,
      required this.reloadData,
      required this.newVehicleSelected
      });

  Vehicle vehicle;
  int selectedVehicleId;
  bool inEditMode;
  Function reloadData;
  Function? editVehicleCallback;
  Function newVehicleSelected;


  @override
  _VehicleTileWidgetState createState() => _VehicleTileWidgetState();
}

class _VehicleTileWidgetState extends State<VehicleTileWidget> {
  @override
  Widget build(BuildContext context) {
    var isSelected =  widget.vehicle.vehicleId == widget.selectedVehicleId;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 1, child: Container()),
        ExpandedSection(
          child: GestureDetector(
            onTap: () async {
              await _showDialog(context, isSelected).then((value) {
                if (value) {
                  widget.reloadData();
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Icon(Icons.delete_outline,
                  color: kInteractionColor.withOpacity(isSelected ? 0.2 : 1)),
            ),
          ),
          expand: widget.inEditMode,
          vertical: false,
        ),
        Expanded(
          flex: (kFlexFactor + 1),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              if (widget.inEditMode) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditVehicleScreen(
                            vehicle: this.widget.vehicle, updateData: widget.reloadData //widget.vehicle.getSelfLink(),
                          )),
                ).then((value) {
                 // widget.editVehicleCallback();
                  widget.reloadData();
                });
              } else {
                widget.newVehicleSelected(widget.vehicle.vehicleId);
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: kFlexFactor,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Text(
                                            widget.vehicle.vehicleName,
                                            style:
                                                kSettingsWidgetSubtitleTextStyle,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          buildVehicleInformation(
                                              widget.vehicle
                                                  .rangeWhenFullInKiloMeters
                                                  .toString(),
                                              ' km',
                                              'Reichweite'),
                                          buildVehicleInformation(
                                              widget.vehicle
                                                  .batteryCapacityInKiloWattHours
                                                  .toString(),
                                              ' kWh',
                                              'Kapazität'),
                                          buildVehicleInformation(
                                              (widget.vehicle
                                                          .immediateChargeTargetStateOfChargeFactor
                                                      )
                                                  .toStringAsFixed(0),
                                              ' %',
                                              'Ladesicherheit'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ExpandedSection(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Icon(Icons.check,
                                        color: isSelected
                                            ? kInteractionColor
                                            : Colors.white),
                                  ),
                                  expand: !widget.inEditMode,
                                  vertical: false,
                                ),
                                ExpandedSection(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 25.0),
                                    child: Icon(Icons.chevron_right,
                                        color: kInteractionColor),
                                  ),
                                  expand: widget.inEditMode,
                                  vertical: false,
                                ),
                              ],
                            ),
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
                  SizedBox(
                      height: 0.5, child: Container(color: Colors.black54)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  deleteVehicle() async{
      await Provider.of<UserService>(context, listen: false).deleteVehicle(widget.vehicle.vehicleId)
    //    .delete(widget.vehicle.getSelfLink())
      .then((value) => (Navigator.pop(context, true)));
  }

  Future _showDialog(context, bool isSelected) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Fahrzeug löschen'),
            content: Text(isSelected
                ? widget.vehicle.vehicleName +
                    ' kann nicht gelöscht werden, da es aktuell ausgewählt ist.'
                : 'Bist du dir sicher, dass du ' +
                    widget.vehicle.vehicleName +
                    ' löschen möchtest?'),
            actions: <Widget>[
              if (!isSelected)
                TextButton(
                  child: const Text(
                    'Löschen',
                    style: TextStyle(color: kInteractionColor),
                  ),
                  onPressed: deleteVehicle,
                ),
              TextButton(
                child: Text(
                  isSelected ? 'OK' : 'Abbrechen',
                  style: TextStyle(color: kInteractionColor),
                ),
                onPressed: () {
                  widget.reloadData();
                  Navigator.pop(context, false);
                },
              )
            ],
          );
        });
  }

  Expanded buildVehicleInformation(String value, String unit, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value + unit,
            style: kSettingsWidgetSubtitleTextStyle,
          ),
          Text(
            label,
            style: kSettingsInformationTextStyle,
          ),
        ],
      ),
    );
  }
}
