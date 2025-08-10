import 'package:dmms/Core/models/error_response.dart';

class ServerException implements Exception {
  ErrorResponse errorResponse;
  ServerException({required this.errorResponse});
  @override
  String toString() {
    return '${errorResponse.errorMessage}\n ${errorResponse.details}';
  }
}

class NoInternetException implements Exception {
  ErrorResponse errorResponse;
  NoInternetException({required this.errorResponse});
  @override
  String toString() {
    return '${errorResponse.errorMessage}\n ${errorResponse.details}';
  }
}

class EmptyException implements Exception {
  ErrorResponse errorResponse;
  EmptyException({required this.errorResponse});
  @override
  String toString() {
    return '${errorResponse.errorMessage}\n ${errorResponse.details}';
  }
}

class UnauthorizedException implements Exception {
  ErrorResponse errorResponse;
  UnauthorizedException({required this.errorResponse});
  @override
  String toString() {
    return '${errorResponse.errorMessage}\n ${errorResponse.details}';
  }
}
