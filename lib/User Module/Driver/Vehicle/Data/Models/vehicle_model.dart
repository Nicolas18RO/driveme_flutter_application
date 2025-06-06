import 'package:drive_me_application_v02/User%20Module/Driver/Vehicle/Domain/vehicle.dart';

class VehicleModel extends Vehicle {
  VehicleModel({
    required String plate,
    required int driver,
    required int typeVehicle,
    required String model,
    required String year,
    required DateTime? soatExpiration,
    required DateTime? tecnicoMecanicaExpiration,
  }) : super(
          plate: plate,
          driver: driver,
          typeVehicle: typeVehicle,
          model: model,
          year: year,
          soatExpiration: soatExpiration,
          tecnicoMecanicaExpiration: tecnicoMecanicaExpiration,
        );

  // Factory constructor to create a DriverModel from JSON
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      plate: json['plate'],
      driver: json['driver'],
      typeVehicle: json['typeVehicle'],
      model: json['model'],
      year: json['year'],
      soatExpiration: json['soatExpiration'],
      tecnicoMecanicaExpiration: json['tecnicoMecanicaExpiration'],
    );
  }

  // Method to convert a DriverModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'plate': plate,
      'driver': driver,
      'typeVehicle': typeVehicle,
      'model': model,
      'year': year,
      'soatExpiration': soatExpiration,
      'tecnicoMecanicaExpiration': tecnicoMecanicaExpiration,
    };
  }
}
