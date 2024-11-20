class Withdrawal {
  final int id;
  final int userId;
  final double amount;
  String status; // e.g., 'pending', 'approved', 'rejected'
  final DateTime requestDate;
  final DateTime? approvalDate; // Optional, if it's approved
  final String? reference; // Optional, for external transaction reference

  Withdrawal({
    required this.id,
    required this.userId,
    required this.amount,
    required this.status,
    required this.requestDate,
    this.approvalDate,
    this.reference,
  });

  factory Withdrawal.fromJson(Map<String, dynamic> json) {
    return Withdrawal(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'].toDouble(),
      status: json['status'],
      requestDate: DateTime.parse(json['request_date']),
      approvalDate: json['approval_date'] != null
          ? DateTime.parse(json['approval_date'])
          : null,
      reference: json['reference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'status': status,
      'request_date': requestDate.toIso8601String(),
      'approval_date': approvalDate?.toIso8601String(),
      'reference': reference,
    };
  }
}
