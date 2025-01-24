class Maintenance {
  final int maintenanceId;
  final String maintenanceType;
  final String comments;
  final DateTime maintenanceDate;
  final double maintenanceCost;
  final int carId;

  Maintenance({
    required this.maintenanceId,
    required this.maintenanceType,
    required this.comments,
    required this.maintenanceDate,
    required this.maintenanceCost,
    required this.carId,
  });

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      maintenanceId: int.parse(json['maintenance_id']),
      maintenanceType: json['maintenance_type'],
      comments: json['comments'],
      maintenanceDate: DateTime.parse(json['maintenance_date']),
      maintenanceCost: double.parse(json['maintenance_cost']),
      carId: int.parse(json['car_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'maintenance_id': maintenanceId,
      'maintenance_type': maintenanceType,
      'comments': comments,
      'maintenance_date': maintenanceDate.toIso8601String(),
      'maintenance_cost': maintenanceCost,
      'car_id': carId,
    };
  }
}
