class Review {
  final String bookingId;
  final String reviewId;
  final String ratings;
  final String comment;
  final String reviewDate;
  final String status;
  final String pickupDate;
  final String dropDate;
  final String carId;
  final String pointId;
  final String personId;
  final String? driverId;

  Review({
    required this.bookingId,
    required this.reviewId,
    required this.ratings,
    required this.comment,
    required this.reviewDate,
    required this.status,
    required this.pickupDate,
    required this.dropDate,
    required this.carId,
    required this.pointId,
    required this.personId,
    this.driverId,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      bookingId: json['booking_id'],
      reviewId: json['review_id'],
      ratings: json['ratings'],
      comment: json['comment'],
      reviewDate: json['review_date'],
      status: json['status'],
      pickupDate: json['pickup_date'],
      dropDate: json['drop_date'],
      carId: json['car_id'],
      pointId: json['point_id'],
      personId: json['person_id'],
      driverId: json['driver_id'],
    );
  }
}