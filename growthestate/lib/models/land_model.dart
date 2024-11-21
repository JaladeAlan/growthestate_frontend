class LandModel {
  final int id;
  final String name;
  final String location;
  final double size;
  final double pricePerUnit;

  LandModel({
    required this.id,
    required this.name,
    required this.location,
    required this.size,
    required this.pricePerUnit,
  });

  factory LandModel.fromJson(Map<String, dynamic> json) {
    return LandModel(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      size: json['size'],
      pricePerUnit: json['price_per_unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,  
      'location': location,
      'size': size,  
      'price_per_unit': pricePerUnit, 
    };
  }
}
