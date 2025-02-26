import 'package:flutter/material.dart';
import 'package:fzi_charging_app/layouts/themes/themeDefs/const_charging_screen.dart';

class ChargingPlanButton extends StatelessWidget {
  const ChargingPlanButton({
    Key? key,
    required this.chartProvider,
    required this.height,
  }) : super(key: key);

  final Function chartProvider;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: kBackgroundColorLight,
      ),
      child: GestureDetector(
        onTap: () => showDialog(
          context: context,
          builder: (_) => SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: Center(child: Text('Erwarteter Ladeplan')),
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: chartProvider.call(),
              ),
              SimpleDialogOption(
                child: Text('Schließen'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.show_chart,
              color: kInteractionColor,
              size: (height * 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
