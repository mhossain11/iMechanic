part of 'new_post_bloc.dart';

sealed class NewPostState extends Equatable {
  const NewPostState();
}

final class NewPostInitial extends NewPostState {
  @override
  List<Object> get props => [];
}
