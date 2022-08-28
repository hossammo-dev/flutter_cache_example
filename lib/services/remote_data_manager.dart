import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cache_data_manager.dart';
import 'models/comment_model.dart';

class DioHelper {
  static Dio? _dio;

  static void init() => _dio = Dio(
        BaseOptions(
          baseUrl: 'https://jsonplaceholder.typicode.com/',
          connectTimeout: 5000,
          receiveTimeout: 3000,
          receiveDataWhenStatusError: true,
        ),
      );

  static Future<dynamic> get() async {
    if (_dio == null) {
      init();
    }
    try {
      final response = await _dio?.get('comments');
      final Box _box = await LocalDataSource.openBox();
      response?.data?.map((x) {
        final Comment _comment = Comment.fromJson(x);
        LocalDataSource.addItems(_box, _comment);
      }).toList();
      return response?.data;
    } on DioError catch (e) {
      return e.response?.data;
    }
  }
}
