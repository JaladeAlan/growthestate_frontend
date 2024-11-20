class Land {
  final int id;
  final String title;
  final double price;
  final String location;

  Land({
    required this.id,
    required this.title,
    required this.price,
    required this.location,
  });

  factory Land.fromJson(Map<String, dynamic> json) {
    return Land(
      id: json['id'],
      title: json['title'],
      price: json['price'].toDouble(),
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'location': location,
    };
  }
}
