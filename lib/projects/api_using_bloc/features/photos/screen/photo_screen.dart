import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/photo_events.dart';
import '../bloc/photos_bloc.dart';
import '../bloc/photos_state.dart';
import '../repos/photos_repository.dart';

class PhotoScreen extends StatelessWidget {
  final int albumId;

  const PhotoScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PhotoBloc(PhotoRepository())..add(FetchPhotos(albumId)),
      child: Scaffold(
        appBar: AppBar(title: Text("Photos of Album #$albumId")),
        body: BlocBuilder<PhotoBloc, PhotoState>(
          builder: (context, state) {
            if (state is PhotoLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PhotoLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1,
                ),
                itemCount: state.photos.length,
                itemBuilder: (context, index) {
                  final photo = state.photos[index];
                  return Card(
                    child: Column(
                      children: [
                        Image.network(photo.thumbnailUrl, height: 80, width: 80),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(photo.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (state is PhotoError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
