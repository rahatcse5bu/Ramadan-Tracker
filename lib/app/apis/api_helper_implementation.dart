import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import '../../modules/login/models/login_request_model.dart';
import '../../modules/login/models/login_response_model.dart';
import '../../modules/register/models/register_model.dart';
import '../common/storage/storage_controller.dart' show StorageHelper;
import '../constants/app_config.dart';
import 'api_helper.dart';
import 'custom_error.dart';


class ApiHelperImpl extends GetConnect implements ApiHelper {
  @override
  void onInit() {
    super.onInit();
    log("API Base URL: \${AppConfig.baseUrl}\${AppConfig.apiVersion}/");
    httpClient.baseUrl = '\${AppConfig.baseUrl}\${AppConfig.apiVersion}/';
    httpClient.timeout = const Duration(seconds: AppConfig.timeoutDuration);
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<Object?>((request) async {
      final token = await StorageHelper.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer \$token';
      }
      log('Request: \${request.method} \${request.url}');
      log('Headers: \${request.headers}');
      return request;
    });

    httpClient.addResponseModifier<Object?>((request, response) {
      log('Response: \${response.statusCode}, Body: \${response.body}');
      return response;
    });
  }

  Future<Either<CustomError, T>> _convert<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) async {
    if (response.statusCode == 200) {
      try {
        return Right(fromJson(response.body));
      } catch (e) {
        return Left(CustomError(response.statusCode, message: 'Parsing error: \$e'));
      }
    } else {
      return Left(CustomError(response.statusCode, message: '\${response.statusText}'));
    }
  }

  @override
  Future<Either<CustomError, LoginResponseModel>> login(
      LoginRequestModel payload) async {
    final response = await post('users/login', payload.toJson());
    return _convert(response, LoginResponseModel.fromJson);
  }

  @override
  Future<Either<CustomError, Response>> register(RegisterRequestModel register) async {
    final response = await post('users', register.toJson());
    return response.statusCode == 200 ? Right(response) : Left(CustomError(response.statusCode, message: response.statusText??''));
  }

  Future<void> fetchAjkerHadith() async {
    final response = await get('ajkerhadiths');
    if (response.statusCode == 200) {
      final data = response.body;
      if (data["success"]) {
        // log("Hadith: \${data["data"][0]["text"]}");
      }
    }
  }

  Future<void> fetchAjkerAyat() async {
    final response = await get('ajkerqurans');
    if (response.statusCode == 200) {
      final data = response.body;
      if (data["success"]) {
        // log("Ayat: \${data["data"][0]["text"]}");
      }
    }
  }

  Future<void> fetchAjkerDua() async {
    final response = await get('ajkerduas');
    if (response.statusCode == 200) {
      final data = response.body;
      if (data["success"]) {
        // log("Dua: \${data["data"][0]["title"]}");
      }
    }
  }
}
