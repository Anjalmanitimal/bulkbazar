import 'package:bulkbazar/features/order/presentation/providers/order_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/order_entity.dart';
import '../../data/repositories/order_repository_impl.dart';

final orderViewModelProvider = StateNotifierProvider<OrderViewModel, bool>((
  ref,
) {
  final repo = ref.read(orderRepositoryProvider);

  return OrderViewModel(repo);
});

class OrderViewModel extends StateNotifier<bool> {
  final OrderRepositoryImpl repository;

  OrderViewModel(this.repository) : super(false);

  Future<void> createOrder(OrderEntity order) async {
    state = true;

    await repository.createOrder(order);

    state = false;
  }
}
