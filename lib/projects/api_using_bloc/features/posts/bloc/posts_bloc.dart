import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reviewer_2025v1/projects/api_using_bloc/features/posts/bloc/posts_event.dart';
import 'package:flutter_reviewer_2025v1/projects/api_using_bloc/features/posts/bloc/posts_state.dart';
import '../repos/post_repository.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {

    on<FetchPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await postRepository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (e) {
        emit(PostError(e.toString()));
      }
    });

  }
}
