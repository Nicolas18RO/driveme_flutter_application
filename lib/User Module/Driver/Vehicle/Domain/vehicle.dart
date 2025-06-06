class Vehicle {
  final String plate; // Primary key
  final int driver;
  final int typeVehicle; //Foreingn key
  final String model;
  final String year;
  final DateTime? soatExpiration;
  final DateTime? tecnicoMecanicaExpiration;

  Vehicle({
    required this.plate,
    required this.driver,
    required this.typeVehicle,
    required this.model,
    required this.year,
    this.soatExpiration,
    this.tecnicoMecanicaExpiration,
  });
}
