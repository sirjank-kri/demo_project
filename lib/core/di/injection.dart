import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';
import '../network/api_client.dart';
import '../../data/datasources/remote_data_source.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../redux/app_state.dart';
import '../../redux/store.dart';

// 🟢 DEPENDENCY INJECTION CONTAINER (Singleton)
final getIt = GetIt.instance;

void setupDependencies() {
  // 1. Register Dio API Client
  getIt.registerSingleton<ApiClient>(ApiClient());

  // 2. Register Data Source (needs Dio from step 1)
  getIt.registerSingleton<RemoteDataSource>(
    RemoteDataSource(getIt<ApiClient>().dio),
  );

  // 3. Register Repository (needs Data Source from step 2)
  getIt.registerSingleton<UserRepository>(
    UserRepository(getIt<RemoteDataSource>()),
  );

  // 4. Register Redux Store
  getIt.registerSingleton<Store<AppState>>(createStore());
}