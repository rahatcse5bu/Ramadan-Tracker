import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:get/get_connect/connect.dart';
import '../../modules/dashboard/models/user_model.dart';
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

    log("url: ${'${AppConfig.baseUrl}${AppConfig.apiVersion}/'}");
    httpClient.baseUrl = '${AppConfig.baseUrl}${AppConfig.apiVersion}/';
    httpClient.timeout = const Duration(seconds: AppConfig.timeoutDuration);
    log("ApiHelperImpl initialized with baseUrl: ${httpClient.baseUrl}");
    httpClient.defaultContentType = 'application/json';

    httpClient.addRequestModifier<Object?>((request) async {
      final token = await StorageHelper.getToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      log('Request: ${request.method} ${request.url}');
      log('Headers: ${request.headers}');
      return request;
    });

    httpClient.addResponseModifier<Object?>((request, response) {
      log('Response: ${response.statusCode}, Body: ${response.body}');
      return response;
    });
  }

  Future<Either<CustomError, T>> _convert<T>(
      Response response, T Function(Map<String, dynamic>) fromJson) async {
    if (response.statusCode == 200) {
      try {
        return Right(fromJson(response.body));
      } catch (e) {
        return Left(
            CustomError(response.statusCode, message: 'Parsing error: \$e'));
      }
    } else {
      return Left(
          CustomError(response.statusCode, message: '\${response.statusText}'));
    }
  }

  @override
  Future<Either<CustomError, LoginResponseModel>> login(
      LoginRequestModel payload) async {
    final response = await post('users/login', payload.toJson());
    return _convert(response, LoginResponseModel.fromJson);
  }

  @override
  Future<Either<CustomError, Response>> register(
      RegisterRequestModel register) async {
    final response = await post('users', register.toJson());
    return response.statusCode == 200
        ? Right(response)
        : Left(CustomError(response.statusCode,
            message: response.statusText ?? ''));
  }

  @override
  Future<Either<CustomError, String>> fetchAjkerAyat() async {
    final response = await get('ajkerqurans');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Right(response.body['data'][0]['text']);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch Ayat'));
    }
  }

  @override
  Future<Either<CustomError, String>> fetchAjkerHadith() async {
    final response = await get('ajkerhadiths');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Right(response.body['data'][0]['text']);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch Hadith'));
    }
  }

  @override
  Future<Either<CustomError, String>> fetchAjkerSalafQuote() async {
    final response = await get('salafquotes');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Right(response.body['data'][0]['text']);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch Salaf Quote'));
    }
  }

  @override
  Future<Either<CustomError, Map<String, dynamic>>> fetchAjkerDua() async {
    final response = await get('ajkerduas');
    if (response.statusCode == 200 && response.body['success'] == true) {
      final data = response.body['data'][0];
      final duaData = {
        'title': data['title'],
        'bangla': data['bangla'],
        'arabic': data['arabic'],
      };
      return Right(duaData);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch Dua'));
    }
  }

  @override
  Future<Either<CustomError, String>> addInputValueForUser(
      int ramadanDay, String value) async {
    final String userId = await StorageHelper.getUserId() ?? '';
    final response = await post('users/add-values/$userId', {
      'day': ramadanDay.toString(),
      'value': value,
    });
    if (response.statusCode == 200) {
      return Right("Value added successfully");
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message:
              response.statusText ?? 'Failed to add value. Please try again.'));
    }
  }

  @override
  Future<Either<CustomError, List<UserModel>>> fetchUsers() async {
    final response = await get('users');
    if (response.statusCode == 200 && response.body['success'] == true) {
      final List<dynamic> jsonList = response.body['data'];
      final List<UserModel> users =
          jsonList.map((item) => UserModel.fromJson(item)).toList();
      return Right(users);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch users'));
    }
  }

  @override
  Future<Either<CustomError, int>> fetchTodaysPoint(
      String userId, int ramadanDay) async {
    final response = await get('users/points/$userId/day$ramadanDay');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Right(response.body['data']['total'] ?? 0);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch today\'s points'));
    }
  }

  @override
  Future<Either<CustomError, Map<String, dynamic>>> fetchUserRanking() async {
    final response = await get('users');
    if (response.statusCode == 200 && response.body['success'] == true) {
      return Right(response.body);
    } else {
      return Left(CustomError(response.statusCode ?? 500,
          message: response.statusText ?? 'Failed to fetch user ranking'));
    }
  }

  @override
  Future<Either<CustomError, Map<String, dynamic>>>
      fetchCurrentUserPoints() async {
    try {
      final response = await get('users');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Right(data);
      }
      return Left(CustomError(response.statusCode ?? 500,
          message: response.body ?? "Failed to fetch user points"));
    } catch (e) {
      return Left(CustomError(500, message: e.toString()));
    }
  }
}
