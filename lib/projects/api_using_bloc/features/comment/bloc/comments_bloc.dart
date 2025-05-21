import 'package:flutter_bloc/flutter_bloc.dart';

import '../repos/comments_repository.dart';
import 'comments_event.dart';
import 'comments_state.dart';


class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository repository;

  CommentBloc(this.repository) : super(CommentInitial()) {
    on<FetchComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await repository.fetchComments();
        emit(CommentLoaded(comments));
      } catch (e) {
        emit(CommentError(e.toString()));
      }
    });
  }
}
