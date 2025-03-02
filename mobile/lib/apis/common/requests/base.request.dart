import 'package:mobile/apis/common/constants/method_type.dart';
import 'package:mobile/apis/common/responses/base.response.dart';

abstract class ApiClient {
  Future<ApiResponse<T>> request<T>({
    required String path,
    required MethodType method,
    Map<String, dynamic>? payload,
    Map<String, dynamic>? queryParameters,
    T Function(Map<String, dynamic> json)? fromJson,
    bool? showLoader,
  });

  // void setToken(String token);
  // void removeToken();
  String handleException(Exception exception);
}