class Booking {
  final int? bookingId;
  final String? status;
  final DateTime? pickupDate;
  final DateTime? dropDate;
  final int? carId;
  final int? pointId;
  final int? personId;
  final int? driverId;
  final String? registrationNumber;
  final String? photo;
  final String? carType;
  final String? modelName;
  final String? manufacturer;
  final String? year;
  final String? availableStatus;
  final DateTime? availableDate;
  final double? amount;

  Booking({
    this.bookingId,
    this.status,
    this.pickupDate,
    this.dropDate,
    this.carId,
    this.pointId,
    this.personId,
    this.driverId,
    this.registrationNumber,
    this.photo,
    this.carType,
    this.modelName,
    this.manufacturer,
    this.year,
    this.availableStatus,
    this.availableDate,
    this.amount,
  });

  // Factory constructor to create a Booking instance from JSON
  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      bookingId: json['booking_id'] != null
          ? int.tryParse(json['booking_id'].toString())
          : null,
      status: json['status'] as String?,
      pickupDate: json['pickup_date'] != null
          ? DateTime.tryParse(json['pickup_date'])
          : null,
      dropDate: json['drop_date'] != null
          ? DateTime.tryParse(json['drop_date'])
          : null,
      carId: json['car_id'] != null
          ? int.tryParse(json['car_id'].toString())
          : null,
      pointId: json['point_id'] != null
          ? int.tryParse(json['point_id'].toString())
          : null,
      personId: json['person_id'] != null
          ? int.tryParse(json['person_id'].toString())
          : null,
      driverId: json['driver_id'] != null
          ? int.tryParse(json['driver_id'].toString())
          : null,
      registrationNumber: json['registration_number'] as String?,
      photo: json['photo'] as String?,
      carType: json['car_type'] as String?,
      modelName: json['model_name'] as String?,
      manufacturer: json['manufacturer'] as String?,
      year: json['year'] as String?,
      availableStatus: json['available_status'] as String?,
      availableDate: json['available_date'] != null
          ? DateTime.tryParse(json['available_date'])
          : null,
      amount: json['amount'] != null
          ? double.tryParse(json['amount'].toString())
          : null,
    );
  }

  // Method to convert a Booking instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'status': status,
      'pickup_date': pickupDate?.toIso8601String(),
      'drop_date': dropDate?.toIso8601String(),
      'car_id': carId,
      'point_id': pointId,
      'person_id': personId,
      'driver_id': driverId,
      'registration_number': registrationNumber,
      'photo': photo,
      'car_type': carType,
      'model_name': modelName,
      'manufacturer': manufacturer,
      'year': year,
      'available_status': availableStatus,
      'available_date': availableDate?.toIso8601String(),
      'amount': amount,
    };
  }
}
