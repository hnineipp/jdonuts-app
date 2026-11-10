class BannerModel {
  final String id;
  final String image;
  final String title;
  final String badge;

  const BannerModel({
    required this.id,
    required this.image,
    required this.title,
    required this.badge,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      badge: json['badge'] ?? '',
    );
  }
}
