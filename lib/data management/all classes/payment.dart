class Payment {
  final int? paymentId;
  final double? payAmount;
  final DateTime? paymentDate;
  final String? paymentType;
  final int? bookingId;

  Payment({
    this.paymentId,
   this.payAmount,
 this.paymentDate,
  this.paymentType,
  this.bookingId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) {
    return Payment(
      paymentId: int.tryParse(json['payment_id']),
      payAmount: double.tryParse(json['pay_amount']),
      paymentDate: DateTime.parse(json['payment_date']),
      paymentType: json['payment_type'],
      bookingId: int.parse(json['booking_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId?.toInt(),
      'pay_amount': payAmount?.toDouble(),
      'payment_date': paymentDate?.toIso8601String(),
      'payment_type': paymentType,
      'booking_id': bookingId?.toInt(),
    };
  }
}