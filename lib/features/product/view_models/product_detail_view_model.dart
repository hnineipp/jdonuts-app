import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:jd_donuts/core/errors/result.dart';
import 'package:jd_donuts/data/store/model/product_model.dart';
import 'package:jd_donuts/data/store/providers/store_provider.dart';

final productDetailViewModelProvider =
    AsyncNotifierProvider.family<ProductDetailViewModel, ProductModel, String>(
  ProductDetailViewModel.new,
);

abstract interface class ProductDetailViewModelContract {
  Future<void> refresh();
}

extension ProductDetailVMX on WidgetRef {
  AsyncValue<ProductModel> productDetailState(String productId) =>
      watch(productDetailViewModelProvider(productId));

  ProductDetailViewModelContract productDetailVM(String productId) =>
      read(productDetailViewModelProvider(productId).notifier);
}

class ProductDetailViewModel extends FamilyAsyncNotifier<ProductModel, String>
    implements ProductDetailViewModelContract {
  late String _productId;

  @override
  Future<ProductModel> build(String productId) async {
    _productId = productId;
    return _loadProduct();
  }

  Future<ProductModel> _loadProduct() async {
    final result = await ref.read(storeServiceProvider).getStoreData();

    return switch (result) {
      Success<Map<String, dynamic>>(:final value) => _findProduct(value),
      Failure<Map<String, dynamic>>(:final failure) =>
        throw StateError(failure.message),
    };
  }

  ProductModel _findProduct(Map<String, dynamic> json) {
    final products = json['products'];

    if (products is! List) {
      throw StateError('Products are unavailable.');
    }

    for (final item in products) {
      if (item is! Map) continue;

      final productJson = Map<String, dynamic>.from(item);

      if (productJson['id']?.toString() == _productId) {
        return ProductModel.fromJson(productJson);
      }
    }

    throw const ProductNotFoundException();
  }

  @override
  Future<void> refresh() async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(_loadProduct);
  }
}

class ProductNotFoundException implements Exception {
  const ProductNotFoundException();

  @override
  String toString() => 'Product not found.';
}
