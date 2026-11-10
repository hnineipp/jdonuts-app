class ProductModel {
  final String id;
  final String code;
  final String name;
  final int priceMmk;
  final bool isNew;
  final int? discountPercent;
  final int? homeDiscountPercent;
  final String image;
  final String description;
  final String section;
  final String? orderAgainTitle;

  const ProductModel({
    required this.id,
    required this.code,
    required this.name,
    required this.priceMmk,
    required this.isNew,
    this.discountPercent,
    this.homeDiscountPercent,
    required this.image,
    required this.description,
    required this.section,
    this.orderAgainTitle,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['id'] ?? '').toString(),
      code: (json['code'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      priceMmk: (json['priceMmk'] as num?)?.toInt() ?? 0,
      isNew: json['isNew'] as bool? ?? false,
      discountPercent: (json['discountPercent'] as num?)?.toInt(),
      homeDiscountPercent: (json['homeDiscountPercent'] as num?)?.toInt(),
      image: (json['image'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      section: (json['section'] ?? '').toString(),
      orderAgainTitle: json['orderAgainTitle']?.toString(),
    );
  }
}
