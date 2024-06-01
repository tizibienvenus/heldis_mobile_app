import 'package:dartz/dartz.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/errors/failures.dart';
import 'package:heldis/screens/profile/controller/profile_remote_datasource.dart';
import 'package:heldis/type/type_def.dart';

class ProfileUseCase {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileUseCase({required this.profileRemoteDataSource});

  ResultFuture<String> delete() async {
    try {
      var response = await profileRemoteDataSource.delete();
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<String> update({
    required String name,
    required String email,
    required String avatar,
    required String phone,
  }) async {
    try {
      var response = await profileRemoteDataSource.update(
        name: name,
        email: email,
        avatar: avatar,
        phone: phone,
      );
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }

  ResultFuture<String> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var response = await profileRemoteDataSource.updatePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: newPassword,
      );
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    }
  }
}
