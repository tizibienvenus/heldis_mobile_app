import 'package:heldis/errors/api_exception.dart';

abstract class Failure {
  const Failure({
    required this.message,
    required this.statusCode,
  });

  // String get errorMessage => '$statusCode Error: $message';
  String get errorMessage => message;

  final String message;
  final String statusCode;
}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});

  APIFailure.fromException(APIException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
