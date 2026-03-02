import '../../domain/entities/order_entity.dart';
import '../datasources/order_remote_datasource.dart';

class OrderRepositoryImpl {
  final OrderRemoteDatasource remoteDatasource;

  OrderRepositoryImpl(this.remoteDatasource);

  Future<void> createOrder(OrderEntity order) async {
    final items = order.items.map((e) {
      return {
        "productId": e.productId,
        "quantity": e.quantity,
        "price": e.price,
      };
    }).toList();

    await remoteDatasource.createOrder(
      items: items,
      totalAmount: order.totalAmount,
    );
  }

  /// NEW
  Future<List<OrderEntity>> getMyOrders() {
    return remoteDatasource.getMyOrders();
  }
}
