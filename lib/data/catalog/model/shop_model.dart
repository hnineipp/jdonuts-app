class ShopModel {
  final String id;
  final String name;
  final String image;
  final String address;

  const ShopModel({
    required this.id,
    required this.name,
    required this.image,
    required this.address,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      address: json['address'] ?? '',
    );
  }
}
