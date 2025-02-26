import 'package:flutter/material.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';

import '../../../model/ChargePoint/chargingTransaction.dart';

class LadenButton extends StatefulWidget {
  final ChargingTransaction? chargingTransaction;

  final Function refresh;
  final Function startCharging;
  final Function stopCharging;


  LadenButton(
    this.chargingTransaction,
    this.startCharging, this.stopCharging,
    this.refresh,

  );

  @override
  _LadenButtonState createState() => _LadenButtonState();
}

class _LadenButtonState extends State<LadenButton> {

  bool _canStartCharging() => true;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_canStartCharging()) {

            if (widget.chargingTransaction == null) {
             widget.startCharging();
            } else {
              _showAlertDialog(context);
            }

          widget.refresh();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color:
              _canStartCharging() ? kInteractionColor : kNoInteractionColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Center(
          child: Text(
            widget.chargingTransaction != null
                ? 'LADUNG BEENDEN'
                : 'LADUNG BEGINNEN',
            style: kLadenButtonTextStyle,
          ),
        ),
      ),
    );
  }

  Future _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          'Sind Sie sicher, dass Sie den Ladevorgang beenden wollen?',
        ),
        content: Text(
          'Sie müssen unter Umständen vor Ort mit ihrem Fahrzeug interagieren bevor Sie einen neuen Ladevorgang beginnen können.',
        ),
        actions: [
          TextButton(
              onPressed: () {

                //  widget.orderManager.cancelOrder();
                  widget.stopCharging();

                Navigator.pop(context);
              },
              child: Text('Ladung beenden')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Abbrechen')),
        ],
      ),
    );
  }
}
