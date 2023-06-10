import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String? message;
  final int? statusCode;
  const Failure({this.message, this.statusCode});

  @override
  List<Object?> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ReadFileFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}
