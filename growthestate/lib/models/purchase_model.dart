class Purchase {
  final int id;
  final int userId;
  final int landId;
  final int units;
  final double totalAmountPaid;

  Purchase({
    required this.id,
    required this.userId,
    required this.landId,
    required this.units,
    required this.totalAmountPaid,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      id: json['id'],
      userId: json['user_id'],
      landId: json['land_id'],
      units: json['units'],
      totalAmountPaid: json['total_amount_paid'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'land_id': landId,
      'units': units,
      'total_amount_paid': totalAmountPaid,
    };
  }
}
