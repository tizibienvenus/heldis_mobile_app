import 'package:dartz/dartz.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/errors/failures.dart';
import 'package:heldis/screens/history/controller/history_remote_datasource.dart';
import 'package:heldis/screens/history/model/coordinate_model.dart';
import 'package:heldis/type/type_def.dart';

class HistoryUseCase {
  final HistoryRemoteDataSource historyRemoteDataSource;

  HistoryUseCase({required this.historyRemoteDataSource});

  ResultFuture<List<CoordinateModel>> getCoordinateHistory({
    required String dateStart,
    required String dateEnd,
  }) async {
    try {
      var response = await historyRemoteDataSource.getCoordinateHistory(
        dateStart: dateStart,
        dateEnd: dateEnd,
      );
      return Right(response.data!);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure.fromException(
          APIException(message: e.toString(), statusCode: "503")));
    }
  }

  ResultFuture<CoordinateModel> getLastPosition() async {
    try {
      var response = await historyRemoteDataSource.getLastPosition();
      return Right(response.data!);
    } on APIException catch (e) {
      return Left(APIFailure.fromException(e));
    } catch (e) {
      return Left(APIFailure.fromException(
          APIException(message: e.toString(), statusCode: "503")));
    }
  }
}
