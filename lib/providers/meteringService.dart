import 'package:flutter/cupertino.dart';
import 'package:fzi_charging_app/model/Metering/meteringCollection.dart';
import 'package:fzi_charging_app/repositories/meteringRepository.dart';
import 'package:provider/provider.dart';

import '../model/Metering/meteringChartData.dart';

class MeteringService {
  BuildContext context;
  MeteringRepository repository;

  MeteringService(this.context)
      : repository = Provider.of<MeteringRepository>(context, listen: false);

  Future<MeteringCollection> getMeterData() {
    return repository.getMeterData();
  }

  Future<List<MeteringChartData>> getChartData() {
    return repository.getChartData();
  }

}