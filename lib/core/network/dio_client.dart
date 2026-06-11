import 'package:dio/dio.dart';
import '../utils/pref_helper.dart';
import 'api_constants.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        /// 🟢 قبل أي Request
        onRequest: (options, handler) async {
          final token = await PrefHelper.getAccessToken();

          print("➡️ Request: ${options.path}");
          print("🔑 Token: ${token ?? 'null'}");

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        /// 🔴 لو حصل Errorش
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            print("🔄 Token Expired → Refreshing...");

            final refreshToken = await PrefHelper.getRefreshToken();

            if (refreshToken == null) {
              return handler.next(error);
            }

            try {
              /// نعمل Refresh Call
              final response = await Dio().post(
                ApiConstants.baseUrl + ApiConstants.refreshToken,
                data: {"refreshToken": refreshToken},
              );

              final newAccess = response.data["data"]["accessToken"];
              final newRefresh = response.data["data"]["refreshToken"];

              /// نخزن الجديد
              await PrefHelper.saveAccessToken(newAccess.toString());
              await PrefHelper.saveRefreshToken(newRefresh.toString());

              print("✅ Token Refreshed");

              /// نعيد نفس الريكوست القديم
              final request = error.requestOptions;

              request.headers["Authorization"] = "Bearer $newAccess";

              final clonedResponse = await _dio.fetch(request);

              return handler.resolve(clonedResponse);
            } catch (e) {
              print("❌ Refresh Failed");

              await PrefHelper.clearTokens();
            }
          }

          return handler.next(error);
        },
      ),
    );

    /// Logs (اختياري)
    _dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true),
    );
  }

  Dio get dio => _dio;
}
