import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/api/api_client.dart';
import '../../data/datasources/order_remote_datasource.dart';
import '../../data/repositories/order_repository_impl.dart';

/// Remote datasource provider
final orderRemoteDatasourceProvider = Provider<OrderRemoteDatasource>((ref) {
  final apiClient = ref.read(apiClientProvider);

  return OrderRemoteDatasource(apiClient);
});

/// Repository provider
final orderRepositoryProvider = Provider<OrderRepositoryImpl>((ref) {
  final remoteDatasource = ref.read(orderRemoteDatasourceProvider);

  return OrderRepositoryImpl(remoteDatasource);
});
