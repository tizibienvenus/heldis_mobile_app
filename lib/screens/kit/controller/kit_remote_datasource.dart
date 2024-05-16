import 'dart:convert';

import 'package:heldis/common/function.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/screens/kit/model/add_zone_response_model.dart';
import 'package:heldis/screens/kit/model/get_all_child_response_model.dart';
import 'package:heldis/type/type_def.dart';
import 'package:http/http.dart' as http;

abstract class KitRemoteDataSource {
  Future<GetAllChildResponseModel> getChildren();

  Future<AddZoneResponseModel> addZone({
    required String zoneName,
    required int radius,
    required double lat,
    required double lng,
    required int childId,
  });

  Future<String> deleteZone({required int zoneId, required int childId});
}

class KitRemoteDataSourceImpl implements KitRemoteDataSource {
  final http.Client client;

  KitRemoteDataSourceImpl({required this.client});

  @override
  Future<GetAllChildResponseModel> getChildren() async {
    try {
      // start the request
      var response = await client.get(
        Uri.https(kBaseUrl, '$kPrefix/child'),
        headers: headersWithToken(),
      );
      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel =
          GetAllChildResponseModel.fromJson(responseJson as DataMap);
      return responseModel;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<AddZoneResponseModel> addZone({
    required String zoneName,
    required int radius,
    required double lat,
    required double lng,
    required int childId,
  }) async {
    Map<String, dynamic> body = {
      'zone_name': zoneName,
      'radius': radius,
      'lat': lat,
      'lng': lng,
    };
    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/child/$childId/zone'),
        body: jsonEncode(body),
        headers: headersWithToken(),
      );
      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel =
          AddZoneResponseModel.fromJson(responseJson as DataMap);
      return responseModel;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<String> deleteZone({required int zoneId, required int childId}) async {
    try {
      // start the request
      var response = await client.delete(
        Uri.https(kBaseUrl, '$kPrefix/child/$childId/zone/$zoneId'),
        headers: headersWithToken(),
      );
      // test the result
      checkResponse(response);
      return "success";
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }
}
