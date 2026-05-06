import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'failures.dart';

class ErrorHandler {
  static String handle(dynamic error) {
    // Log original error for developer
    debugPrint('*** Developer Error Log ***');
    debugPrint('Error Type: ${error.runtimeType}');
    debugPrint('Error Details: $error');
    if (error is DioException) {
      debugPrint('Dio Error Type: ${error.type}');
      debugPrint('Dio Response: ${error.response}');
      debugPrint('Dio Message: ${error.message}');
    }
    debugPrint('**************************');

    // Return user-friendly message
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return 'Connection timed out. Please check your internet.';
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          if (statusCode == 404) return 'The requested resource was not found.';
          if (statusCode == 500) return 'Server error. Please try again later.';
          return 'Received invalid response from server ($statusCode).';
        case DioExceptionType.cancel:
          return 'Request to server was cancelled.';
        case DioExceptionType.connectionError:
          return 'No internet connection or server is unreachable.';
        default:
          return 'Something went wrong while connecting to the server.';
      }
    }

    if (error is Failure) {
      return error.message;
    }

    return 'An unexpected error occurred. Please try again.';
  }
}
