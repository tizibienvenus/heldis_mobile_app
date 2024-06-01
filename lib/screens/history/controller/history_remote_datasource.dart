import 'dart:convert';

import 'package:heldis/common/function.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/screens/history/model/get_coordinate_history_response_model.dart';
import 'package:heldis/screens/history/model/get_last_position_response_model.dart';
import 'package:heldis/type/type_def.dart';
import 'package:http/http.dart' as http;

abstract class HistoryRemoteDataSource {
  Future<GetCoordinateHistoryResponseModel> getCoordinateHistory(
      {required String dateStart, required String dateEnd});
  Future<GetLastPositionResponseModel> getLastPosition();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  final http.Client client;

  HistoryRemoteDataSourceImpl({required this.client});

  @override
  Future<GetCoordinateHistoryResponseModel> getCoordinateHistory({
    required String dateStart,
    required String dateEnd,
  }) async {
    Map<String, dynamic> body = {
      'from': dateStart,
      'to': dateEnd,
    };
    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/coordinate-history'),
        body: jsonEncode(body),
        headers: headersWithToken(),
      );
      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel =
          GetCoordinateHistoryResponseModel.fromJson(responseJson as DataMap);
      return responseModel;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  Future<GetLastPositionResponseModel> getLastPosition() async {
    try {
      // start the request
      var response = await client.get(
        Uri.https(kBaseUrl, '$kPrefix/gps-last-position'),
        headers: headersWithToken(),
      );
      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel =
          GetLastPositionResponseModel.fromJson(responseJson as DataMap);
      return responseModel;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }
}
