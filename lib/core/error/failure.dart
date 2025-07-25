import 'package:equatable/equatable.dart';

class Failure with EquatableMixin {
  const Failure({this.message});

  Failure.empty() : message = null;

  final String? message;

  @override
  List<Object?> get props => [message];
}
