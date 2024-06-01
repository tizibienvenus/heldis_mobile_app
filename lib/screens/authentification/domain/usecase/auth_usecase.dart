import 'package:dartz/dartz.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/errors/failures.dart';
import 'package:heldis/screens/authentification/data/datasource/auth_remote_datasource.dart';
import 'package:heldis/screens/authentification/data/model/login_response_model.dart';
import 'package:heldis/screens/authentification/data/model/register_response_model.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';
import 'package:heldis/type/type_def.dart';

class AuthUsecase {
  AuthRemoteDataSource authRemoteDataSource;

  AuthUsecase({required this.authRemoteDataSource});

  ResultFuture<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await authRemoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<RegisterResponseModel> register({
    required String email,
    required String password,
    required String name,
    required String phone,
    required String avatar,
  }) async {
    try {
      var response = await authRemoteDataSource.register(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      );

      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<UserEntity> getUserInfo() async {
    try {
      var response = await authRemoteDataSource.getUser();

      return Right(response.user!.toEntity());
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<String> logout() async {
    try {
      var response = await authRemoteDataSource.logout();

      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<String> registerKit({
    required String name,
    required String avatar,
    required String birthDate,
    required String gpsSimNumber,
    required String description,
  }) async {
    // start the request
    try {
      var response = await authRemoteDataSource.registerKit(
        name: name,
        avatar: avatar,
        birthDate: birthDate,
        gpsSimNumber: gpsSimNumber,
        description: description,
      );

      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
