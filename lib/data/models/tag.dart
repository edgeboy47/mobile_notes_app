import 'package:equatable/equatable.dart';

class Tag extends Equatable {
  const Tag({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}
