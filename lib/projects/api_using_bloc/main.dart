import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/albums/bloc/albums_bloc.dart';
import 'features/albums/repos/albums_repository.dart';
import 'features/albums/screen/album_screen.dart';
import 'features/comment/bloc/comments_bloc.dart';
import 'features/comment/repos/comments_repository.dart';
import 'features/comment/screen/comment_screen.dart';
import 'features/photos/screen/photo_screen.dart';
import 'features/posts/bloc/posts_bloc.dart';
import 'features/posts/repos/post_repository.dart';
import 'features/posts/screen/posts_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PostBloc(PostRepository())),
        BlocProvider(create: (_) => CommentBloc(CommentRepository())),
        BlocProvider(create: (_) => AlbumBloc(AlbumRepository())),
      ],
      child: MaterialApp(
        title: 'BLoC JSONPlaceholder',
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JSONPlaceholder BLoC')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Posts'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PostScreen()),
                ),
          ),
          ListTile(
            title: const Text('Comments'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CommentScreen()),
                ),
          ),
          ListTile(
            title: const Text('Albums'),
            onTap:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AlbumScreen()),
                ),
          ),
          ListTile(
            title: const Text('Photo'),
            onTap:
                () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PhotoScreen(albumId: 1,)),
            ),
          ),
        ],
      ),
    );
  }
}
