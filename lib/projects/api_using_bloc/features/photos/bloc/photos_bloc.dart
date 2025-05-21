import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reviewer_2025v1/projects/api_using_bloc/features/photos/bloc/photo_events.dart';
import 'package:flutter_reviewer_2025v1/projects/api_using_bloc/features/photos/bloc/photos_state.dart';

import '../repos/photos_repository.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  final PhotoRepository repository;

  PhotoBloc(this.repository) : super(PhotoInitial()) {
    on<FetchPhotos>((event, emit) async {
      emit(PhotoLoading());
      try {
        final photos = await repository.fetchPhotosByAlbum(event.albumId);
        emit(PhotoLoaded(photos));
      } catch (e) {
        emit(PhotoError(e.toString()));
      }
    });
  }
}
