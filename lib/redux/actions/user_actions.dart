import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import '../../data/models/user_model.dart';
import '../../data/models/post_model.dart';
import '../../core/di/injection.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../app_state.dart';

// ==========================================
// REGULAR ACTIONS (instant, no API call)
// ==========================================

class LoadingAction {}

class FetchUsersSuccessAction {
  final List<UserModel> users;
  FetchUsersSuccessAction(this.users);
}

class FetchPostsSuccessAction {
  final List<PostModel> posts;
  FetchPostsSuccessAction(this.posts);
}

class ErrorAction {
  final String error;
  ErrorAction(this.error);
}

class ClearPostsAction {}

// ==========================================
// 🟢 REDUX THUNK ACTIONS (async API calls)
// ==========================================

// Thunk: Fetches all users from the API
ThunkAction<AppState> fetchUsersThunk() {
  return (Store<AppState> store) async {
    // Step 1: Tell the store we're loading
    store.dispatch(LoadingAction());

    try {
      // Step 2: Get repository from DI and call API
      final repository = getIt<UserRepository>();
      final users = await repository.getUsers();

      // Step 3: Tell the store we got the data
      store.dispatch(FetchUsersSuccessAction(users));
    } catch (e) {
      // Step 4: Tell the store something went wrong
      store.dispatch(ErrorAction(e.toString()));
    }
  };
}

// Thunk: Fetches posts for a specific user
ThunkAction<AppState> fetchPostsThunk(int userId) {
  return (Store<AppState> store) async {
    store.dispatch(LoadingAction());

    try {
      final repository = getIt<UserRepository>();
      final posts = await repository.getPostsByUserId(userId);
      store.dispatch(FetchPostsSuccessAction(posts));
    } catch (e) {
      store.dispatch(ErrorAction(e.toString()));
    }
  };
}