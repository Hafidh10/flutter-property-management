// lib/property.dart
class Property {
  final int id;
  final String title;
  final String address;
  final double price;
  final int bedrooms;
  final String? description;
  final String? image;

  Property({
    required this.id,
    required this.title,
    required this.address,
    required this.price,
    required this.bedrooms,
    this.description,
    this.image,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'],
      title: json['title'],
      address: json['address'],
      price: double.parse(json['price']),
      bedrooms: json['bedrooms'],
      description: json['description'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'address': address,
      'price': price.toString(),
      'bedrooms': bedrooms,
      'description': description,
      'image': image,
    };
  }
}
