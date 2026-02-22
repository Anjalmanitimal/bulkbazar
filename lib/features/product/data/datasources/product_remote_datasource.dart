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
    required File image,
    required List<PricingEntity> pricing,
  }) async {
    // ✅ CHECK FILE EXISTS
    if (!await image.exists()) {
      throw Exception("Image file not found at path: ${image.path}");
    }

    // ✅ CONVERT PRICING TO JSON STRING (IMPORTANT FOR BACKEND)
    final pricingJson = jsonEncode(
      pricing.map((e) => {"moq": e.moq, "price": e.price}).toList(),
    );

    // ✅ CREATE MULTIPART FILE SAFELY
    final multipartImage = await MultipartFile.fromFile(
      image.path,
      filename: image.path.split('/').last,
    );

    final formData = FormData.fromMap({
      "name": name,
      "description": description,
      "pricing": pricingJson,
      "image": multipartImage,
    });

    // ✅ DEBUG PRINT
    print("Uploading image path: ${image.path}");
    print("File exists: ${await image.exists()}");

    await apiClient.post(
      "/products",
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );
  }

  Future<List<ProductModel>> getProducts() async {
    final response = await apiClient.get("/products");

    return (response.data['data'] as List)
        .map((e) => ProductModel.fromJson(e))
        .toList();
  }
}
