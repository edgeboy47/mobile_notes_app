import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_notes_app/data/data_sources/hive_db.dart';
import 'package:mobile_notes_app/data/models/tag.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  TagsBloc(this.db) : super(TagsLoading());

  final HiveDatabase db;
  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    if(event is TagsLoaded) {
      
    }
  }
}
