import 'dart:convert';

import 'package:heldis/common/extension.dart';
import 'package:heldis/errors/api_exception.dart';
import 'package:http/http.dart' as http;

/// checkResponse method
void checkResponse(http.Response response) {
  if (response.statusCode == 500) {
    throw APIException(
      message: "The server encountered a problem. Please try again later !",
      statusCode: response.statusCode.toString(),
    );
  }
  if (response.statusCode != 200 && response.statusCode != 201) {
    String message = "";
    List<String> messageList = [];
    var result = json.decode(response.body.toString());
    if (result['message'] == "error") {
      (result as Map).forEach((key, value) {
        if (value == true) {
          messageList.add(key);
          message = "${message + key}\n";
        }
      });
      message.replaceLast("\n", "");
    }
    if (message == "") {
      message = result['errors']?.toString() ??
          result['message'] ??
          response.toString();
    }

    throw APIException(
      message: message,
      statusCode: response.statusCode.toString(),
    );
  }
}
