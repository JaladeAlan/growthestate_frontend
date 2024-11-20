class BankDetail {
  final int userId;
  final String bankName;
  final String accountNumber;
  final String accountHolderName;

  BankDetail({
    required this.userId,
    required this.bankName,
    required this.accountNumber,
    required this.accountHolderName,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) {
    return BankDetail(
      userId: json['user_id'],
      bankName: json['bank_name'],
      accountNumber: json['account_number'],
      accountHolderName: json['account_holder_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'bank_name': bankName,
      'account_number': accountNumber,
      'account_holder_name': accountHolderName,
    };
  }
}
