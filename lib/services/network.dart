import 'package:dio/dio.dart';
import 'package:gotech_flutter_assignment/core/utils.dart';

//a simple network manager
class NetworkManager {
  final Dio dio;

  const NetworkManager._(this.dio);

  factory NetworkManager() {
    final dio = Dio();
    return NetworkManager._(dio);
  }

  Future<Response<T>> request<T>(
    RequestMethod method,
    String url, {
    data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return dio.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(
        method: method.value,
        headers: headers,
      ),
    );
  }
}

enum RequestMethod {
  get,
  head,
  post,
  put,
  delete,
  connect,
  options,
  trace,
  patch,
}

//conversion of lowercase enum to uppercase for dio
extension RequestMethodX on RequestMethod {
  String get value => getEnumValue(this).toUpperCase();
}
