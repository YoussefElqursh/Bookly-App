import 'package:dio/dio.dart';

abstract class Failure{
 final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure{
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection timeout with API server");
      case DioExceptionType.unknown:
        return ServerFailure("Connection to API server failed due to internet connection");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive timeout in connection with API server");
      case DioExceptionType.cancel:
        return ServerFailure("Request to API server was cancelled");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send timeout in connection with API server");
      default:
        return ServerFailure("Something went wrong, try again later.");
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic message) {
    if (statusCode == 400) {
      return ServerFailure(message!);
    } else if (statusCode == 401) {
      return ServerFailure(message!);
    } else if (statusCode == 403) {
      return ServerFailure(message!);
    } else if (statusCode == 404) {
      return ServerFailure(message!);
    } else if (statusCode == 500) {
      return ServerFailure(message!);
    } else {
      return ServerFailure("Unexpected error occurred");
    }
  }
}