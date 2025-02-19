import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../modules/dashboard/models/user_model.dart';
import '../../modules/login/models/login_request_model.dart'
    show LoginRequestModel;
import '../../modules/login/models/login_response_model.dart';
import '../../modules/register/models/register_model.dart';
import 'custom_error.dart';

abstract class ApiHelper {
  // Future<Either<CustomError, LoginResponse>> login(LoginRequestModel login);
  Future<Either<CustomError, LoginResponseModel>> login(
      LoginRequestModel payload);

  Future<Either<CustomError, Response>> register(RegisterRequestModel register);
  Future<Either<CustomError, String>> fetchAjkerAyat();
  Future<Either<CustomError, String>> fetchAjkerHadith();
  Future<Either<CustomError, String>> fetchAjkerSalafQuote();
  Future<Either<CustomError, List<UserModel>>> fetchUsers();
  Future<Either<CustomError, int>> fetchTodaysPoint(
      String userId, int ramadanDay);
  Future<Either<CustomError, Map<String, dynamic>>> fetchUserRanking();
     Future<Either<CustomError, Map<String, dynamic>>> fetchCurrentUserPoints();
}
