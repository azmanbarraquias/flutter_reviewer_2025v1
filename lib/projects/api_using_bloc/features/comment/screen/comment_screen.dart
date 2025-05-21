import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/comments_bloc.dart';
import '../bloc/comments_event.dart';
import '../bloc/comments_state.dart';


class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comments")),
      body: BlocBuilder<CommentBloc, CommentState>(
        builder: (context, state) {
          if (state is CommentInitial) {
            context.read<CommentBloc>().add(FetchComments());
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CommentLoaded) {
            return ListView.builder(
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                final c = state.comments[index];
                return ListTile(
                  title: Text(c.name),
                  subtitle: Text(c.body),
                  trailing: Text(c.email),
                );
              },
            );
          } else if (state is CommentError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
