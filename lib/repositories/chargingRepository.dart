
import '../model/ChargePoint/chargePriceForecast.dart';
import '../model/ChargePoint/chargingTransaction.dart';
import '../providers/backendClient.dart';

class ChargingRepository extends BackendClient{
  ChargingRepository(super.baseUrl);

  Future<ChargePriceForecast> getPriceForecast(int chargePointId){

  return this.post<ChargePriceForecast>("ChargePoint/$chargePointId/PriceCalculation/",{}, (data) => ChargePriceForecast.fromJson(data) );
  }

  Future<ChargingTransaction> startChargeTransaction(int chargePointId){
    return this.put<ChargingTransaction>("ChargePoint/$chargePointId/charge",{}, (data) => ChargingTransaction.fromJson(data) );
  }

  Future<void> stopChargeTransaction(int chargePointId, String transactionUid){
    return this.post<void>("ChargePoint/$chargePointId/charge/$transactionUid/stop",{}, (data) => null );
  }

  Future<ChargingTransaction> getTransactionState(int chargePointId, String transactionUid){
    return this.get<ChargingTransaction>("ChargePoint/$chargePointId/charge/$transactionUid", (data) => ChargingTransaction.fromJson(data) );
  }

  Future<List<ChargingTransaction>> getTransactions(int chargePointId){
    return this.get<List<ChargingTransaction>>("ChargePoint/$chargePointId/transactions/", (data) => ChargingTransaction.fromJsonList(data) );
  }


}