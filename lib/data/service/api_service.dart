import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:personal_finance_app/utils/classes/result.dart';
import 'package:personal_finance_app/utils/const/server_consts.dart';

@lazySingleton
/// The API service.
class ApiService {
  /// The Dio instance.
  final dio = _createDio();

  static Dio _createDio() {
    const duration = Duration(seconds: 15);
    final dio = Dio(
      BaseOptions(
        baseUrl: remoteTransactionsFileUrl,
        receiveTimeout: duration, // 15 seconds
        connectTimeout: duration,
        sendTimeout: duration,
        // headers: {'accept': 'application/json'},
        validateStatus: (status) {
          return status! != 401 && status < 500;
        },
      ),
    );
    return dio;
  }

  /// Fetches data from the API.
  Future<Result<Response<dynamic>, Exception>> get(
    String url, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? customHeaders,
    Options? customOptions,
  }) async {
    if (customHeaders != null) {
      dio.options.headers.addAll(customHeaders);
    }

    if (params != null) dio.options.queryParameters = params;
    try {
      return Success(await Dio().get(url));
    } on DioException catch (e) {
      return Failure(e);
    }
  }
}
