

import 'package:flutter/material.dart';
import 'package:fzi_charging_app/repositories/chargingRepository.dart';
import 'package:provider/provider.dart';

import '../model/ChargePoint/chargePriceForecast.dart';
import '../model/ChargePoint/chargingTransaction.dart';

class ChargingService{
  ChargingRepository repository;
  ChargingService(BuildContext context) :
    repository =  Provider.of<ChargingRepository>(context, listen: false);

  Future<ChargePriceForecast> getPriceForecast(int chargePointId){
    return repository.getPriceForecast(chargePointId);
  }

  Future<ChargingTransaction> startChargingTransaction(int chargePointId){
    return repository.startChargeTransaction(chargePointId);
  }

  Future<void> stopChargingTransaction(ChargingTransaction transaction){
    return repository.stopChargeTransaction(transaction.chargePointId, transaction.transactionId);
  }

  Future<ChargingTransaction> getTransactionState(int chargePointId, String transactionId){
    return repository.getTransactionState(chargePointId, transactionId);
  }

  Future<List<ChargingTransaction>> getRunningTransactions(int chargePointId){
    return repository.getTransactions(chargePointId);
  }



}