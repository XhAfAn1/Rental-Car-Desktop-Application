class CarDetails {
  final int? carId;
  final String? registrationNumber;
  final String? photo;
  final String? carType;
  final String? modelName;
  final String? manufacturer;
  final String? year;
  final String? available_status;
  final DateTime? available_date;
  final double? amount;
  final double? OverAll_ratings;

  CarDetails({
    this.carId,
    this.registrationNumber,
    this.photo,
    this.carType,
    this.modelName,
    this.manufacturer,
    this.year,
    this.available_status,
    this.available_date,
    this.amount,
    this.OverAll_ratings,
  });

  /// Factory method to create a `CarDetails` object from JSON
  factory CarDetails.fromJson(Map<String, dynamic> json) {
    return CarDetails(
      carId: json['CarID'] != null ? int.tryParse(json['CarID'].toString()) : null,
      registrationNumber: json['RegistrationNumber'],
      photo: json['Photo'],
      carType: json['CarType'],
      modelName: json['ModelName'],
      manufacturer: json['Manufacturer'],
      year: json['Year'],
      available_status: json['AvailabilityStatus'],
      available_date: json['AvailabilityDate'] != null
          ? DateTime.tryParse(json['AvailabilityDate'])
          : null,
      amount: json['CostPerDay'] != null
          ? double.tryParse(json['CostPerDay'].toString())
          : null,
      OverAll_ratings: json['OverAll_ratings'] != null
          ? double.tryParse(json['OverAll_ratings'].toString())
          : null,
    );
  }

  /// Converts a `CarDetails` object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'CarID': carId?.toString(),
      'RegistrationNumber': registrationNumber,
      'Photo': photo,
      'CarType': carType,
      'ModelName': modelName,
      'Manufacturer': manufacturer,
      'Year': year,
      'AvailabilityStatus': available_status,
      'AvailabilityDate': available_date?.toIso8601String(),
      'CostPerDay': amount?.toString(),
      'OverAll_ratings': OverAll_ratings?.toString(),
    };
  }
}
