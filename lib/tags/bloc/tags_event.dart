part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  const TagsEvent();

  @override
  List<Object> get props => [];
}

class TagAdded extends TagsEvent {
  TagAdded(this.tag);

  final Tag tag;

  @override
  List<Object> get props => [tag];
}

class TagDeleted extends TagsEvent {
  TagDeleted(this.tag);

  final Tag tag;
}

class TagUpdated extends TagsEvent {
  TagUpdated(this.tag);

  final Tag tag;
  @override
  List<Object> get props => [tag];
}

class TagsLoaded extends TagsEvent {}
