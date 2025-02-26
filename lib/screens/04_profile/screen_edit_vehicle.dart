import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fzi_charging_app/providers/UserService.dart';
import 'package:provider/provider.dart';
import '../../layouts/themes/themeDefs/const.dart';
import '../../layouts/themes/themeDefs/const_charging_screen.dart';
import '../../layouts/themes/themeDefs/const_settings.dart';
import '../../model/UserProfile/vehicle.dart';

class EditVehicleScreen extends StatefulWidget {
  EditVehicleScreen({required this.vehicle, required this.updateData});

  Vehicle? vehicle;
  Function updateData;


  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  String header = 'Fahrzeug bearbeiten';
  String? nameErrorText;
  String? rangeErrorText;
  String? batteryCapacityErrorText;
  String? maxPowerErrorText;
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController rangeTextEditingController = TextEditingController();
  TextEditingController batteryCapacityTextEditingController =
  TextEditingController();
  TextEditingController maxPowerTextEditingController = TextEditingController();
  bool saving = false;

  @override
  void initState() {
    super.initState();

   if(widget.vehicle != null) {
     nameTextEditingController.text = widget.vehicle!.vehicleName;
     rangeTextEditingController.text =
         widget.vehicle!.rangeWhenFullInKiloMeters.toString();
     batteryCapacityTextEditingController.text =
         widget.vehicle!.batteryCapacityInKiloWattHours.toString();
     maxPowerTextEditingController.text =
         (widget.vehicle!.maximumPowerInWatts ~/ 1000).toString();
   }
   else{
     widget.vehicle = new Vehicle("",0,0,0,0,0,0);
   }


  }

  @override
  void dispose() {
    nameTextEditingController.dispose();
    rangeTextEditingController.dispose();
    batteryCapacityTextEditingController.dispose();
    maxPowerTextEditingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(),
          ),
          Expanded(
            flex: kFlexFactor,
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 50),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.arrow_back),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(header, style: kHeaderTextStyle,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    buildTextField(
                        '',
                        'Name des Fahrzeugs',
                        nameErrorText,
                        nameTextEditingController,
                        TextInputType.text, <TextInputFormatter>[]),
                    buildTextField(
                        'km',
                        'Maximale Reichweite in Kilometer',
                        rangeErrorText,
                        rangeTextEditingController,
                        TextInputType.numberWithOptions(signed: false, decimal: false), <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ]),
                    buildTextField(
                        'kWh',
                        'Batterie Kapazität in Kilowattstunde',
                        batteryCapacityErrorText,
                        batteryCapacityTextEditingController,
                        TextInputType.numberWithOptions(signed: false, decimal: false), <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ]),
                    buildTextField(
                        'kW',
                        'Maximale Ladeleistung in Kilowatt',
                        maxPowerErrorText,
                        maxPowerTextEditingController,
                        TextInputType.numberWithOptions(signed: false, decimal: false), <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ]),
                    buildImmediateChargeTargetSlider(),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: kInteractionColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: MaterialButton(
                              onPressed: () async {
                                if (checkName() &&
                                    checkRange() &&
                                    checkbatteryCapacity() &&
                                    checkMaxPower()) {
                                updateVehicle();
                                }
                              },
                              child: saving ? CircularProgressIndicator() :  Text(
                                'Speichern',
                                style: kSettingsSubtitleTextStyle.copyWith(
                                    fontSize: 13, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )


          ),
          Expanded(
            child: Container(),
          ),
        ],
      ),
    );
  }

  updateVehicle() async{

    setState(()=>saving = true);
   UserService service = Provider.of<UserService>(context, listen: false);
   Vehicle v = widget.vehicle!;
   v.vehicleName = nameTextEditingController.text;
   v.rangeWhenFullInKiloMeters = int.parse(rangeTextEditingController.text);
   v.batteryCapacityInKiloWattHours = int.parse(batteryCapacityTextEditingController.text);
   v.maximumPowerInWatts = int.parse(maxPowerTextEditingController.text);
   if(widget.vehicle!.vehicleId==0){
     await service.addVehicle(v);
   }else{ await  service.updateVehilce(v);}
   widget.updateData();
    Navigator.pop(context);
    setState(()=>saving = false);
  }

  bool checkName() {
    String result = nameTextEditingController.text;
    if (result.isEmpty) {
      setState(() {
        nameErrorText = 'Das Feld darf nicht leer sein';
      });
      return false;
    } else {
      setState(() {
        nameErrorText = null;
      });
      return true;
    }
  }

  bool checkRange() {
    String result = rangeTextEditingController.text;
    if (result.isEmpty) {
      setState(() {
        rangeErrorText = 'Das Feld darf nicht leer sein';
      });
      return false;
    } else {
      if (int.tryParse(result) == null) {
        setState(() {
          rangeErrorText = 'Keine gültige Eingabe';
        });
        return false;
      }
      if (int.tryParse(result) != null) {
        setState(() {
          rangeErrorText = null;
        });
      }
      return true;
    }
  }

  bool checkbatteryCapacity() {
    String result =
        batteryCapacityTextEditingController.text;
    if (result.isEmpty) {
      setState(() {
        batteryCapacityErrorText = 'Das Feld darf nicht leer sein';
      });
      return false;
    } else {
      if (int.tryParse(result) == null) {
        setState(() {
          batteryCapacityErrorText = 'Keine gültige Eingabe';
        });
        return false;
      }
      if (int.tryParse(result) != null) {
        setState(() {
          batteryCapacityErrorText = null;
        });
      }
      return true;
    }
  }

  bool checkMaxPower() {
    String result = maxPowerTextEditingController.text;
    if (result.isEmpty) {
      setState(() {
        maxPowerErrorText = 'Das Feld darf nicht leer sein';
      });
      return false;
    } else {
      if (int.tryParse(result) == null) {
        setState(() {
          maxPowerErrorText = 'Keine gültige Eingabe';
        });
        return false;
      }
      if (int.tryParse(result) != null) {
        setState(() {
          maxPowerErrorText = null;
        });
      }
      return true;
    }
  }

  Padding buildTextField(
      String suffix,
      String labelText,
      String? errorText,
      TextEditingController controller,
      TextInputType keyboardType,
      List<TextInputFormatter> textinputformatter) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            errorText: errorText,
            suffix: Text(suffix),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kInteractionColor),
            ),
            labelText: labelText,
            labelStyle:
            kWorkSansTextStyle.copyWith(color: Colors.grey.shade800)),
        keyboardType: keyboardType,
        inputFormatters: textinputformatter,
      ),
    );
  }

  Padding buildImmediateChargeTargetSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children:    [ Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Sofort Laden bis...',
                    style: kSettingsInformationTextStyle,
                  ),
                  Text(
                    '${ widget.vehicle == null ? "" : (widget.vehicle!.immediateChargeTargetStateOfChargeFactor).toStringAsFixed(0)} %',
                    style: kSettingsInformationTextStyle,
                  ),
                ],
              ),
              Slider(
                activeColor: kInteractionColor,
                inactiveColor: kNoInteractionColor,
                value: (widget.vehicle== null ? 0 : widget.vehicle!.immediateChargeTargetStateOfChargeFactor/100),
                onChanged: (double newValue) {
                  setState(() {
                    widget.vehicle!.immediateChargeTargetStateOfChargeFactor = (newValue*100).toInt();
                  });
                },
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'Diese Reichweite kann unabhängig vom gewählten Lademodus sofort geladen werden',
                textAlign: TextAlign.center,
                style: kSettingsInformationTextStyle,
              ),


      ]),
    );
  }
}