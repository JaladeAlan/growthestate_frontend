class Notification {
  final int id;
  final int userId;
  final String title;
  final String message;
  final DateTime date;

  Notification({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      message: json['message'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'message': message,
      'date': date.toIso8601String(),
    };
  }
}
