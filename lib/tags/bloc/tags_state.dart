part of 'tags_bloc.dart';

abstract class TagsState extends Equatable {
  const TagsState();

  @override
  List<Object> get props => [];
}

class TagsLoading extends TagsState {}

class TagsLoadSuccess extends TagsState {
  TagsLoadSuccess(this.tags);

  final List<Tag> tags;

  @override
  List<Object> get props => [tags];
}

class TagsLoadFailed extends TagsState {}
