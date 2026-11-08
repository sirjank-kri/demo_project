import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../redux/app_state.dart';
import '../../redux/actions/user_actions.dart';
import '../widgets/user_card.dart';
import '../widgets/loading_indicator.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch users after the first frame renders
    WidgetsBinding.instance.addPostFrameCallback((_) {
      StoreProvider.of<AppState>(context).dispatch(fetchUsersThunk());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Explorer'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: StoreConnector<AppState, AppState>(
        converter: (Store<AppState> store) => store.state,
        builder: (context, state) {
          // Show loading spinner
          if (state.isLoading && state.users.isEmpty) {
            return const LoadingIndicator();
          }

          // Show error with retry button
          if (state.error != null && state.users.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Error: ${state.error}',
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      StoreProvider.of<AppState>(context)
                          .dispatch(fetchUsersThunk());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          // Show user list
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              final user = state.users[index];
              return UserCard(
                user: user,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          UserDetailScreen(user: user),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}