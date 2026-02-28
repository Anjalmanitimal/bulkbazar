import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/api/api_client.dart';
import '../models/cart_model.dart';

final cartRemoteDatasourceProvider = Provider<CartRemoteDatasource>((ref) {
  final api = ref.read(apiClientProvider);
  return CartRemoteDatasource(api);
});

class CartRemoteDatasource {
  final ApiClient api;

  CartRemoteDatasource(this.api);

  Future<List<CartModel>> getCart() async {
    final response = await api.get("/cart");

    final List data = response.data['data'];

    return data.map((e) => CartModel.fromJson(e)).toList();
  }

  Future<void> updateQuantity(String cartId, int quantity) async {
    await api.put("/cart/$cartId", data: {"quantity": quantity});
  }

  Future<void> checkout() async {
    await api.post("/orders");
  }
}
