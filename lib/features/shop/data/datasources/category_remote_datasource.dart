// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:dio/dio.dart';

// import '../models/category_model.dart';

// final categoryRemoteDatasourceProvider = Provider<CategoryRemoteDatasource>((
//   ref,
// ) {
//   return CategoryRemoteDatasource(Dio());
// });

// class CategoryRemoteDatasource {
//   final Dio dio;

//   CategoryRemoteDatasource(this.dio);

//   Future<List<CategoryModel>> getCategories() async {
//     final response = await dio.get("http://10.0.2.2:5000/api/category");

//     final data = response.data as List;

//     return data.map((e) => CategoryModel.fromJson(e)).toList();
//   }
// }
