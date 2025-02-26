


import '../model/UserProfile/chargeSettings.dart';
import '../model/UserProfile/userProfile.dart';
import '../model/UserProfile/vehicle.dart';
import '../providers/backendClient.dart';

class UserProfileRepository extends BackendClient{

UserProfileRepository(super.baseUrl);

Future<UserProfile> getUserProfile(){
  return this.get<UserProfile>("Profile/", (data) => UserProfile.fromJson(data));
}

//region Vehicle Operations
Future<List<Vehicle>> getVehicleList(){
  return this.get<List<Vehicle>>("Profile/vehicles", (data) => fromJsonList<Vehicle>(data, (jsonElem) => Vehicle.fromJson(jsonElem)));
}

Future<Vehicle> getVehicleById(int id){
  return this.get<Vehicle>("Profile/vehicles/$id", (data)=>Vehicle.fromJson(data));
}

Future<void> deleteVehicle(int id){
  return this.delete("Profile/vehicles/$id", (data) => null);
}

Future<Vehicle> updateVehicle(Vehicle vehicle){
  return this.post("Profile/vehicles", vehicle.toJson(), (data) => Vehicle.fromJson(data));
}

Future<Vehicle> addVehicle(Vehicle v){
  return this.put("Profile/vehicles", v.toJson(), (data) => Vehicle.fromJson(data));
}
//endregion


  //region charge settings operations
 Future<ChargeSettings> getChargeSettings(){
  return this.get<ChargeSettings>("Profile/chargeSettings", (data)=> ChargeSettings.fromJson(data));
  }

  Future<ChargeSettings> updateChargeSettings(ChargeSettings toUpdate){
  return this.post("Profile/chargeSettings", toUpdate.toJson(), (data) => ChargeSettings.fromJson(data));
  }
  
  Future<void> updateSelectedVehicle(int vehicleId){
  return this.post("Profile/currentVehicle?vehicleId=$vehicleId", {}, (data) => null);
  }

  Future<void> updateSelectedChargePoint(int chargePointId){
    return this.post("Profile/currentChargepoint?chargePointId=$chargePointId", {}, (data) => null);
  }
  //endregion





}