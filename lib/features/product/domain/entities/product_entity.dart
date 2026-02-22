class PricingEntity {
  final int moq;
  final double price;

  PricingEntity({required this.moq, required this.price});
}

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<PricingEntity> pricing;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.pricing,
  });
}
