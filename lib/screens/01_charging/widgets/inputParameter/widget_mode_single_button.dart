import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fzi_charging_app/utils/number_formatting.dart';
import '/layouts/themes/themeDefs/const_charging_screen.dart';

import '../../../98_general/media_query.dart';

class ChargingModeChip extends StatefulWidget {
  ChargingModeChip({
    required this.titel,
    required this.description,
    required this.priceDifference,
    required this.icon_selected,
    required this.icon_default,
    required this.selected,
  });

  String titel;
  String description;
  double priceDifference;
  IconData icon_selected;
  IconData icon_default;
  bool selected;

  @override
  _ChargingModeChipState createState() => _ChargingModeChipState();
}

class _ChargingModeChipState extends State<ChargingModeChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQueryUtils.heightIsAbove720(context)
          ? MediaQuery.of(context).size.height * 0.13
          : MediaQuery.of(context).size.height * 0.088,
      decoration: BoxDecoration(
        color: widget.selected ? kBackgroundColorDark : kBackgroundColorLight,
        border: Border.all(
          color: widget.selected ? kBackgroundColorDark : kBackgroundColorLight,
          width: 8.0,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Icon(
                  widget.selected ? widget.icon_selected : widget.icon_default,
                  color: widget.selected ? kInteractionColor : kDeactivated,
                  size: 20,
                ),
              ),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    widget.titel,
                    style: kChargingModeButtonTitelStyle.copyWith(
                        color:
                            widget.selected ? kInteractionColor : kDeactivated),
                  ),
                ),
              ),
            ],
          ),
          MediaQueryUtils.heightIsAbove720(context) &&
                  MediaQueryUtils.widthIsAbove350(context)
              ? Text(
                  widget.description,
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  style: widget.selected
                      ? kChargingModeButtonDescriptionStyle.copyWith(
                          color: kInteractionColor)
                      : kChargingModeButtonDescriptionStyle.copyWith(
                          color: kDeactivated,
                        ),
                )
              : Container(),
          Expanded(
            child: Container(),
          ),
          if (widget.priceDifference != 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  widget.priceDifference.isNegative
                      ? NumberFormatters.regEuroFormatter
                          .format(widget.priceDifference)
                      : NumberFormatters.euroFormatterWithPlusSign
                          .format(widget.priceDifference),
                  style: kChargingModeButtonTitelStyle.copyWith(
                    color: widget.selected ? kInteractionColor : kDeactivated,
                    fontSize:
                        MediaQueryUtils.heightIsAbove590(context) ? 14 : 10,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
