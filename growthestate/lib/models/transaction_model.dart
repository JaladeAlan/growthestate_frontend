class Transaction {
  final int id;
  final int userId;
  final double amount;
  final String type; // e.g., 'deposit', 'purchase', 'withdrawal'
  String status; // e.g., 'pending', 'completed', 'failed'
  final DateTime date;
  final String? reference; // Optional, for external transaction reference

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.status,
    required this.date,
    this.reference,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      userId: json['user_id'],
      amount: json['amount'].toDouble(),
      type: json['type'],
      status: json['status'],
      date: DateTime.parse(json['date']),
      reference: json['reference'], // Optional
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'amount': amount,
      'type': type,
      'status': status,
      'date': date.toIso8601String(),
      'reference': reference, // Optional
    };
  }
}
