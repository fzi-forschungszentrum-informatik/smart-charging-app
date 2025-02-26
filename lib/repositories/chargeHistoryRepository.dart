import 'package:fzi_charging_app/model/ChargeHistory/chargeHistoryItem.dart';

import '../providers/backendClient.dart';

class ChargeHistoryRepository extends BackendClient{
  ChargeHistoryRepository(super.baseUrl);

  Future<List<ChargeHistoryItem>> fetchChargeHistoryList(int offset) async {
  return this.get<List<ChargeHistoryItem>>("ChargeHistory/$offset", (data) => ChargeHistoryItem.fromJsonList(data));
  }

}