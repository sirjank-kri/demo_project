import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../../data/models/user_model.dart';
import '../../redux/app_state.dart';
import '../../redux/actions/user_actions.dart';
import '../widgets/loading_indicator.dart';

class UserDetailScreen extends StatefulWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final store = StoreProvider.of<AppState>(context);
      store.dispatch(ClearPostsAction());
      store.dispatch(fetchPostsThunk(widget.user.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.blue.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.blue.shade200,
                    child: Text(
                      widget.user.name[0].toUpperCase(),
                      style: const TextStyle(
                          fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(widget.user.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('📧  ${widget.user.email}'),
                  const SizedBox(height: 4),
                  Text('📱  ${widget.user.phone}'),
                  const SizedBox(height: 4),
                  Text('🌐  ${widget.user.website}'),
                  const SizedBox(height: 4),
                  Text('🏢  ${widget.user.company}'),
                ],
              ),
            ),

            // Posts Section Header
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Posts',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
            ),

            // Posts List from Redux Store
            StoreConnector<AppState, AppState>(
              converter: (Store<AppState> store) => store.state,
              builder: (context, state) {
                if (state.isLoading) {
                  return const SizedBox(
                      height: 200, child: LoadingIndicator());
                }

                if (state.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text('Error: ${state.error}',
                          style: const TextStyle(color: Colors.red)),
                    ),
                  );
                }

                if (state.posts.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('No posts found.'),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.title.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(post.body,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13)),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}