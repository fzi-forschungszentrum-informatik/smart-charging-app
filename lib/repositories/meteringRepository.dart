
import 'package:fzi_charging_app/model/Metering/meteringChartData.dart';

import '../model/Metering/meteringCollection.dart';
import '../providers/backendClient.dart';

class MeteringRepository extends BackendClient{
  MeteringRepository(super.baseUrl);

  Future<MeteringCollection> getMeterData(){
    return this.get<MeteringCollection>("/metering/meters", (data) => MeteringCollection.fromJson(data) );
  }

  Future<List<MeteringChartData>> getChartData(){
    return this.get<List<MeteringChartData>>("metering/chart", (data) => MeteringChartData.fromJsonList(data) );
  }


}