import '../app_state.dart';
import '../actions/user_actions.dart';

// The reducer takes the current state + an action, and returns a NEW state
AppState appReducer(AppState state, dynamic action) {
  if (action is LoadingAction) {
    return state.copyWith(isLoading: true, clearError: true);
  }

  if (action is FetchUsersSuccessAction) {
    return state.copyWith(
      users: action.users,
      isLoading: false,
    );
  }

  if (action is FetchPostsSuccessAction) {
    return state.copyWith(
      posts: action.posts,
      isLoading: false,
    );
  }

  if (action is ErrorAction) {
    return state.copyWith(
      isLoading: false,
      error: action.error,
    );
  }

  if (action is ClearPostsAction) {
    return state.copyWith(
      posts: [],
      clearError: true,
    );
  }

  return state;
}