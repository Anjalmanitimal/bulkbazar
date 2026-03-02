import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/order_entity.dart';
import '../../data/repositories/order_repository_impl.dart';
import '../providers/order_providers.dart';

class OrderState {
  final bool loading;
  final List<OrderEntity> orders;

  OrderState({required this.loading, required this.orders});

  factory OrderState.initial() {
    return OrderState(loading: false, orders: []);
  }

  OrderState copyWith({bool? loading, List<OrderEntity>? orders}) {
    return OrderState(
      loading: loading ?? this.loading,
      orders: orders ?? this.orders,
    );
  }
}

final orderViewModelProvider =
    StateNotifierProvider<OrderViewModel, OrderState>((ref) {
      final repo = ref.read(orderRepositoryProvider);
      return OrderViewModel(repo);
    });

class OrderViewModel extends StateNotifier<OrderState> {
  final OrderRepositoryImpl repository;

  OrderViewModel(this.repository) : super(OrderState.initial()) {
    loadOrders();
  }

  Future<void> loadOrders() async {
    try {
      state = state.copyWith(loading: true);

      final orders = await repository.getMyOrders();

      state = state.copyWith(loading: false, orders: orders);
    } catch (e) {
      print("LOAD ORDERS ERROR: $e");

      state = state.copyWith(loading: false, orders: []);
    }
  }

  Future<void> createOrder(OrderEntity order) async {
    await repository.createOrder(order);
    await loadOrders();
  }

  Future<void> deleteOrder(String orderId) async {
    await repository.deleteOrder(orderId);
    await loadOrders();
  }
}
