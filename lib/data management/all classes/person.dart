class Person {
  final int? personId;
  final String firstName;
  final String lastName;
  final String? name;
  final DateTime? dob;
  final int? age;
  final String? phoneNumber;
  final String? phoneNumber2;
  final String? email;
  final String? street;
  final String? city;
  final String? state;
  final String? zip;
  final int? customerId;
  final int? driverId;
  final String? drivingLicenseNumber;
  final int? staffId;
  final String? staffRole;
  final String? membership;
  final double? salary;
  final double? totalBooking;
  final double? totalPayment;
  final String? username;
  final String? password;

  Person({
    this.personId,
    required this.firstName,
    required this.lastName,
    this.name,
    this.dob,
    this.age,
    this.phoneNumber,
    this.phoneNumber2,
    this.email,
    this.street,
    this.city,
    this.state,
    this.zip,
    this.customerId,
    this.driverId,
    this.drivingLicenseNumber,
    this.staffId,
    this.staffRole,
    this.membership,
    this.salary,
    this.username,
    this.password,
    this.totalBooking,
    this.totalPayment,
  });

  /// Creates a `Person` object from a JSON map.
  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      personId: int.tryParse(json['PersonID']),
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      name: json['Name'],
      dob: json['DOB'] != null ? DateTime.tryParse(json['DOB']) : null,
      age: json['Age'] != null ? int.tryParse(json['Age'].toString()) : null,
      phoneNumber: json['PhoneNumber'],
      phoneNumber2: json['PhoneNumber2'],
      email: json['Email'],
      street: json['Street'],
      city: json['City'],
      state: json['State'],
      zip: json['Zip'],
      customerId: json['CustomerID'] != null ? int.tryParse(json['CustomerID'].toString()) : null,
      driverId: json['DriverID'] != null ? int.tryParse(json['DriverID'].toString()) : null,
      drivingLicenseNumber: json['DrivingLicenseNumber'],
      staffId: json['StaffID'] != null ? int.tryParse(json['StaffID'].toString()) : null,
      staffRole: json['StaffRole'],
      membership: json['membership']?.toString(),
      salary: json['Salary'] != null ? double.tryParse(json['Salary'].toString()) : null,
      totalBooking: json['Total_booking'] != null ? double.tryParse(json['Total_booking'].toString()) : null,
      totalPayment: json['Total_payment'] != null ? double.tryParse(json['Total_payment'].toString()) : null,
      username: json['username'],
      password: json['password'],
    );
  }

  /// Converts a `Person` object to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'PersonID': personId?.toString(),
      'FirstName': firstName,
      'LastName': lastName,
      'Name': name,
      'DOB': dob?.toIso8601String(),
      'Age': age?.toString(),
      'PhoneNumber': phoneNumber,
      'PhoneNumber2': phoneNumber2,
      'Email': email,
      'Street': street,
      'City': city,
      'State': state,
      'Zip': zip,
      'CustomerID': customerId?.toString(),
      'DriverID': driverId?.toString(),
      'DrivingLicenseNumber': drivingLicenseNumber,
      'StaffID': staffId?.toString(),
      'StaffRole': staffRole,
      'membership': membership?.toString(),
      'Salary': salary?.toString(),
      'Total_booking': totalBooking?.toString(),
      'Total_payment': totalPayment?.toString(),
      'username': username,
      'password': password,
    };
  }
}
