import 'dart:io';
import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api/api_client.dart';
import '../models/product_model.dart';
import '../../domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productRemoteDatasourceProvider = Provider<ProductRemoteDatasource>((
  ref,
) {
  final apiClient = ref.read(apiClientProvider);
  return ProductRemoteDatasource(apiClient);
});

class ProductRemoteDatasource {
  final ApiClient apiClient;

  ProductRemoteDatasource(this.apiClient);

  Future<void> addProduct({
    required String name,
    required String description,
    required String category,
    required File image,
    required List<PricingEntity> pricing,
  }) async {
    if (!await image.exists()) {
      throw Exception("Image file not found at path: ${image.path}");
    }

    final pricingJson = jsonEncode(
      pricing.map((e) => {"moq": e.moq, "price": e.price}).toList(),
    );

    final multipartImage = await MultipartFile.fromFile(
      image.path,
      filename: image.path.split('/').last,
    );

    final formData = FormData.fromMap({
      "name": name,
      "description": description,
      "category": category,
      "pricing": pricingJson,
      "image": multipartImage,
    });

    await apiClient.post(
      "/products", // ✅ FIXED
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.get(
      "/products/seller", // ✅ FIXED
    );

    return (response.data['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }

  Future<void> updateProduct({
    required String productId,
    required String name,
    required String description,
    required String category,
    File? image,
    required List<PricingEntity> pricing,
  }) async {
    final pricingJson = jsonEncode(
      pricing.map((e) => {"moq": e.moq, "price": e.price}).toList(),
    );

    FormData formData = FormData.fromMap({
      "name": name,
      "description": description,
      "category": category,
      "pricing": pricingJson,
    });

    if (image != null) {
      formData.files.add(
        MapEntry("image", await MultipartFile.fromFile(image.path)),
      );
    }

    await apiClient.put(
      "/products/$productId", // ✅ FIXED
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );
  }

  Future<void> deleteProduct(String productId) async {
    await apiClient.delete("/products/$productId");
  }
}
