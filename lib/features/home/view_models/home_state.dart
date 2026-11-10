import 'package:jd_donuts/data/store/model/banner_model.dart';
import 'package:jd_donuts/data/store/model/member_model.dart';
import 'package:jd_donuts/data/store/model/product_model.dart';
import 'package:jd_donuts/data/store/model/shop_model.dart';

class HomeData {
  const HomeData({
    required this.member,
    required this.products,
    required this.banners,
    required this.shops,
    required this.orderAgainProducts,
    required this.hasProducts,
    required this.hasBanners,
    required this.hasShops,
    required this.hasOrderAgainProducts,
  });

  final MemberModel member;
  final List<ProductModel> products;
  final List<BannerModel> banners;
  final List<ShopModel> shops;
  final List<ProductModel> orderAgainProducts;

  final bool hasProducts;
  final bool hasBanners;
  final bool hasShops;
  final bool hasOrderAgainProducts;

  List<ProductModel> get seasonalProducts => products
      .where(
        (product) =>
            product.section.trim().toLowerCase() == 'seasonal specials',
      )
      .toList(growable: false);

  List<ProductModel> get popularProducts => products
      .where((product) => product.section.toLowerCase() == 'popular')
      .toList();

  factory HomeData.fromJson(Map<String, dynamic> json) {
    final products = _parseProducts(json['products']);

    return HomeData(
      member: MemberModel.fromJson(_parseMap(json['member'])),
      products: products,
      banners: _parseBanners(json['banners']),
      shops: _parseShops(json['shops']),
      orderAgainProducts: _parseOrderAgain(
        json['orderAgainProductIds'],
        products,
      ),
      hasProducts: json['products'] is List,
      hasBanners: json['banners'] is List,
      hasShops: json['shops'] is List,
      hasOrderAgainProducts: json['orderAgainProductIds'] is List,
    );
  }

  static Map<String, dynamic> _parseMap(dynamic value) {
    if (value is! Map) return {};
    return Map<String, dynamic>.from(value);
  }

  static List<Map<String, dynamic>> _parseList(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList(growable: false);
  }

  static List<ProductModel> _parseProducts(dynamic value) {
    return _parseList(value).map(ProductModel.fromJson).toList(growable: false);
  }

  static List<BannerModel> _parseBanners(dynamic value) {
    return _parseList(value).map(BannerModel.fromJson).toList(growable: false);
  }

  static List<ShopModel> _parseShops(dynamic value) {
    return _parseList(value).map(ShopModel.fromJson).toList(growable: false);
  }

  static List<ProductModel> _parseOrderAgain(
    dynamic ids,
    List<ProductModel> products,
  ) {
    if (ids is! List) return [];

    final productsById = {
      for (final product in products) product.id: product,
    };

    return ids
        .map((id) => productsById[id.toString()])
        .whereType<ProductModel>()
        .toList(growable: false);
  }
}
