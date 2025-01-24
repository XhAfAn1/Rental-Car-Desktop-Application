class HirePoint {
  final int pointId;
  final String pointName;
  final String street;
  final String state;
  final String city;
  final String zip;

  HirePoint({
    required this.pointId,
    required this.pointName,
    required this.street,
    required this.state,
    required this.city,
    required this.zip,
  });

  factory HirePoint.fromJson(Map<String, dynamic> json) {
    return HirePoint(
      pointId: int.parse(json['point_id']),
      pointName: json['point_name'],
      street: json['street'],
      state: json['state'],
      city: json['city'],
      zip: json['zip'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'point_id': pointId,
      'point_name': pointName,
      'street': street,
      'state': state,
      'city': city,
      'zip': zip,
    };
  }
}