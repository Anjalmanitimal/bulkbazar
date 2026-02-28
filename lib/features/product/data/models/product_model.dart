import '../../domain/entities/product_entity.dart';

class PricingModel extends PricingEntity {
  PricingModel({required super.moq, required super.price});

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(moq: json['moq'], price: json['price'].toDouble());
  }

  Map<String, dynamic> toJson() {
    return {"moq": moq, "price": price};
  }
}

class ProductModel extends ProductEntity {
  ProductModel({
    required super.id,
    required super.name,
    required super.description,
    required super.image,
    required super.pricing,
    required super.category,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      category: json['category'] ?? "",
      pricing: (json['pricing'] as List)
          .map((e) => PricingModel.fromJson(e))
          .toList(),
    );
  }
}
