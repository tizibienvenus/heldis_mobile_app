import 'package:dartz/dartz.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/errors/failures.dart';
import 'package:heldis/screens/kit/controller/kit_remote_datasource.dart';
import 'package:heldis/screens/kit/model/child_zone_model.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';
import 'package:heldis/type/type_def.dart';

class KitUseCase {
  final KitRemoteDataSource kitRemoteDataSource;

  KitUseCase({required this.kitRemoteDataSource});

  ResultFuture<List<ChildModel>> getChildren() async {
    try {
      var response = await kitRemoteDataSource.getChildren();
      return Right(response.data!);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure.fromException(
          APIException(message: e.toString(), statusCode: "503")));
    }
  }

  ResultFuture<ChildZone> addZone({
    required String zoneName,
    required int radius,
    required double lat,
    required double lng,
    required int childId,
  }) async {
    try {
      var response = await kitRemoteDataSource.addZone(
        zoneName: zoneName,
        radius: radius,
        lat: lat,
        lng: lng,
        childId: childId,
      );
      return Right(response.data!);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure.fromException(
          APIException(message: e.toString(), statusCode: "503")));
    }
  }

  ResultFuture<String> deleteZone(
      {required int zoneId, required int childId}) async {
    try {
      var response = await kitRemoteDataSource.deleteZone(
        zoneId: zoneId,
        childId: childId,
      );
      return Right(response);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure.fromException(
          APIException(message: e.toString(), statusCode: "503")));
    }
  }
}
