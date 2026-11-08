import '../data/models/user_model.dart';
import '../data/models/post_model.dart';

class AppState {
  final List<UserModel> users;
  final List<PostModel> posts;
  final bool isLoading;
  final String? error;

  AppState({
    required this.users,
    required this.posts,
    required this.isLoading,
    this.error,
  });

  // Initial empty state when app first opens
  factory AppState.initial() {
    return AppState(
      users: [],
      posts: [],
      isLoading: false,
      error: null,
    );
  }

  // Creates a copy with only the fields you want to change
  AppState copyWith({
    List<UserModel>? users,
    List<PostModel>? posts,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return AppState(
      users: users ?? this.users,
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}