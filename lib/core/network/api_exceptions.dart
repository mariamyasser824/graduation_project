import 'package:dio/dio.dart';
import 'api_error.dart';

class ApiExceptions {

  static ApiError handleError(DioException error) {

    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    /// لو السيرفر رجّع رسالة
    if (data is Map<String, dynamic>) {
      if (data['message'] != null) {
        return ApiError(
          message: data['message'],
          statusCode: statusCode,
        );
      }
    }

    /// Validation / Email exists
    if (statusCode == 400) {
      return ApiError(
        message:
            "Validation error or email already exists",
        statusCode: statusCode,
      );
    }

    /// Network errors
    switch (error.type) {

      case DioExceptionType.connectionTimeout:
        return ApiError(
          message:
              "Connection timeout. Check internet",
        );

      case DioExceptionType.sendTimeout:
        return ApiError(
          message:
              "Request timeout. Try again",
        );

      case DioExceptionType.receiveTimeout:
        return ApiError(
          message:
              "Server took too long to respond",
        );

      case DioExceptionType.badResponse:
        return ApiError(
          message:
              "Server error. Please try later",
          statusCode: statusCode,
        );

      default:
        return ApiError(
          message:
              "Unexpected error occurred",
        );
    }
  }
}
