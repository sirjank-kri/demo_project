import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'core/di/injection.dart';
import 'redux/app_state.dart';
import 'presentation/screens/user_list_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies(); // 🟢 Initialize ALL dependencies here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: getIt(), // 🟢 Get Redux Store from DI
      child: MaterialApp(
        title: 'User Explorer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          useMaterial3: true,
        ),
        home: const UserListScreen(),
      ),
    );
  }
}