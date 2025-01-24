class Report {
  final int reportId;
  final String description;
  final DateTime reportDate;
  final String status;
  final int bookingId;

  Report({
    required this.reportId,
    required this.description,
    required this.reportDate,
    required this.status,
    required this.bookingId,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportId: int.tryParse(json['report_id'])!,
      description: json['description'],
      reportDate: DateTime.parse(json['report_date']),
      status: json['status'],
      bookingId: int.tryParse(json['booking_id'])!,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'report_id': reportId,
      'description': description,
      'report_date': reportDate.toIso8601String(),
      'status': status,
      'booking_id': bookingId,
    };
  }
}