import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:heldis/screens/authentification/domain/entities/user_entity.dart';

final box = GetStorage();
String? token = box.read('token');

var headers = {
  HttpHeaders.contentTypeHeader: 'application/json',
  HttpHeaders.acceptHeader: 'application/json',
  /* HttpHeaders.accessControlAllowOriginHeader: "*",
  HttpHeaders.accessControlAllowMethodsHeader:
      "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  HttpHeaders.accessControlAllowHeadersHeader:
      "Origin, X-Requested-With, Content-Type, Accept", */
  // HttpHeaders.authorizationHeader: 'Bearer $token',
};

Map<String, String> headersWithToken() => {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
      /* HttpHeaders.accessControlAllowOriginHeader: "*",
  HttpHeaders.accessControlAllowMethodsHeader:
      "POST, GET, OPTIONS, PUT, DELETE, HEAD",
  HttpHeaders.accessControlAllowHeadersHeader:
      "Origin, X-Requested-With, Content-Type, Accept", */
      HttpHeaders.authorizationHeader: 'Bearer ${box.read('token')}',
    };

UserEntity? users = UserEntity.fromJson(box.read("user"));

bool isConnected() {
  return token != null;
}
