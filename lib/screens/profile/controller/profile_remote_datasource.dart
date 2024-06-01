import 'dart:convert';

import 'package:heldis/common/function.dart';
import 'package:heldis/constants/constants.dart';
import 'package:heldis/constants/general.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:http/http.dart' as http;

abstract class ProfileRemoteDataSource {
  Future<String> delete();
  Future<String> update(
      {required String name,
      required String email,
      required String avatar,
      required String phone});
  Future<String> updatePassword(
      {required String oldPassword,
      required String newPassword,
      required String confirmPassword});
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final http.Client client;

  ProfileRemoteDataSourceImpl({required this.client});
  @override
  Future<String> delete() async {
    try {
      // start the request
      var response = await client.delete(
        Uri.https(kBaseUrl, '$kPrefix/user/delete'),
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

  @override
  Future<String> update({
    required String name,
    required String email,
    required String avatar,
    required String phone,
  }) async {
    var body = {'name': name, 'email': email, 'avatar': avatar, 'phone': phone};
    try {
      // start the request
      var response = await client.put(
        Uri.https(kBaseUrl, '$kPrefix/user/update'),
        body: jsonEncode(body),
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

  @override
  Future<String> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    var body = {
      'old_password': oldPassword,
      'password': newPassword,
      'password_confirmation': confirmPassword
    };
    try {
      // start the request
      var response = await client.put(
        Uri.https(kBaseUrl, '$kPrefix/user/update_password'),
        body: jsonEncode(body),
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
