import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';

class RemoteDataSource {
  final Dio _dio;

  // 🟢 DEPENDENCY INJECTION - Dio is passed in, not created here
  RemoteDataSource(this._dio);

  Future<List<UserModel>> fetchUsers() async {
    final response = await _dio.get(ApiConstants.users);
    final List<dynamic> data = response.data;
    return data.map((json) => UserModel.fromJson(json)).toList();
  }

  Future<List<PostModel>> fetchPostsByUserId(int userId) async {
    final response = await _dio.get(
      ApiConstants.posts,
      queryParameters: {'userId': userId},
    );
    final List<dynamic> data = response.data;
    return data.map((json) => PostModel.fromJson(json)).toList();
  }
}