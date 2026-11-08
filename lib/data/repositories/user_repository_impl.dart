import '../models/user_model.dart';
import '../models/post_model.dart';
import '../datasources/remote_data_source.dart';

// 🟢 REPOSITORY PATTERN
// The rest of the app talks to this class, NOT directly to the API.
// If you add a local database later, you only change this file.
class UserRepository {
  final RemoteDataSource _remoteDataSource;

  // 🟢 DEPENDENCY INJECTION
  UserRepository(this._remoteDataSource);

  Future<List<UserModel>> getUsers() async {
    try {
      return await _remoteDataSource.fetchUsers();
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<List<PostModel>> getPostsByUserId(int userId) async {
    try {
      return await _remoteDataSource.fetchPostsByUserId(userId);
    } catch (e) {
      throw Exception('Failed to fetch posts: $e');
    }
  }
}