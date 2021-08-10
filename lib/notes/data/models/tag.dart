import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'tag.g.dart';

@HiveType(typeId: 1)
class Tag extends Equatable {
  const Tag({required this.title});

  @HiveField(0)
  final String title;

  @override
  List<Object?> get props => [title];
}
