import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/albums_bloc.dart';
import '../bloc/albums_event.dart';
import '../bloc/albums_state.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Albums")),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumInitial) {
            context.read<AlbumBloc>().add(FetchAlbums());
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            return ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                final a = state.albums[index];
                return ListTile(
                  title: Text("Album #${a.id}"),
                  subtitle: Text(a.title),
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
