import 'dart:convert';

import 'package:heldis/common/function.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:heldis/screens/authentification/data/model/get_user_response_model.dart';
import 'package:heldis/type/type_def.dart';
import 'package:http/http.dart' as http;

import 'package:heldis/screens/authentification/data/model/login_response_model.dart';
import 'package:heldis/screens/authentification/data/model/register_response_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  });
  Future<RegisterResponseModel> register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String avatar});

  Future<GetUserInfoResponseModel> getUser();
  Future<String> logout();

  Future<bool> update(
      String email, String password, String name, String phone, String avatar);

  Future<String> registerKit({
    required String name,
    required String avatar,
    required String birthDate,
    required String gpsSimNumber,
    required String description,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<LoginResponseModel> login({
    required String email,
    required String password,
  }) async {
    var body = {
      'email': email,
      'password': password,
    };

    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/auth/login'),
        body: jsonEncode(body),
        headers: headers,
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel = LoginResponseModel.fromJson(responseJson as DataMap);
      await box.write('token', responseModel.data!.token);
      await box.write('user', responseModel.data!.user!.toEntity().toJson());
      return responseModel;
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<RegisterResponseModel> register(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String avatar}) async {
    var body = {
      'email': email,
      'password': password,
      'password_confirmation': password,
      'name': name,
      'phone': phone,
      'avatar': avatar
    };

    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/auth/register'),
        body: jsonEncode(body),
        headers: headers,
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      return RegisterResponseModel.fromJson(responseJson as DataMap);
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<bool> update(
      String email, String password, String name, String phone, String avatar) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<GetUserInfoResponseModel> getUser() async {
    try {
      // start the request
      var response = await client.get(
        Uri.https(kBaseUrl, '$kPrefix/user'),
        headers: headersWithToken(),
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      var responseModel =
          GetUserInfoResponseModel.fromJson(responseJson as DataMap);

      await box.write("user", responseModel.user?.toEntity().toJson());

      return responseModel;
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<String> logout() async {
    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/auth/logout'),
        headers: headersWithToken(),
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      return (responseJson as DataMap)["message"];
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<String> registerKit({
    required String name,
    required String avatar,
    required String birthDate,
    required String gpsSimNumber,
    required String description,
  }) async {
    var body = {
      "name": name,
      "avatar": avatar,
      "birth_date": birthDate,
      "gps_sim_number": gpsSimNumber,
      "description": description,
    };

    try {
      // start the request
      var response = await client.post(
        Uri.https(kBaseUrl, '$kPrefix/child'),
        body: jsonEncode(body),
        headers: headersWithToken(),
      );

      // test the result
      checkResponse(response);
      var responseJson = json.decode(response.body.toString());
      return "success";
      //
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: '505');
    }
  }
}
