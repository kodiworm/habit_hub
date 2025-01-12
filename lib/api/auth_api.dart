import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/utils.dart';

class AuthApi {

  var mapData = <String, dynamic>{};

  static Future<ApiResponse> login({required authData}) async {
    ApiResponse apiResponse = ApiResponse();

    try {

      final response = await http.post(
          Uri.parse(loginUrl),
          body: authData,
          headers: headers
      ).timeout(requestDuration);

      var responseBody = jsonDecode(response.body);

      print("auth api response");
      print(response.body);

      switch(response.statusCode) {
        case 200:
          apiResponse.result = responseBody;
          apiResponse.data = responseBody['user_data'];
          break;
        case 422:
          final errors = responseBody['errors'];
          apiResponse.error = errors[errors.key.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = unauthorizedError;
          break;
        case 500:
          apiResponse.error = responseBody['error_message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }

      if(responseBody['status'] == 500) {
        apiResponse.error = responseBody['error_message'];
      }

    } on TimeoutException {

      apiResponse.error = timeoutError;

    } on SocketException {

      apiResponse.error = socketError;

    } on Error catch(e) {

      print("login fatal error");
      print(e.stackTrace);

      apiResponse.error = e.toString();
    }

    return apiResponse;
  }

  static Future<ApiResponse> register({required registerData}) async {
    ApiResponse apiResponse = ApiResponse();

    print("registration data");
    print(registerData);

    try {
      final response = await http.post(
          Uri.parse(registerUrl),
          body: registerData,
          headers: headers
      ).timeout(requestDuration);

      print("registration response");
      print(response.body);

      switch(response.statusCode) {
        case 200:
          apiResponse.result = jsonDecode(response.body);
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = unauthorizedError;
          break;
        case 500:
          apiResponse.error = jsonDecode(response.body)['error_message'];
          break;
        default:
          apiResponse.error = somethingWentWrong;
          break;
      }

    } on TimeoutException {

      apiResponse.error = timeoutError;

    } on SocketException {

      apiResponse.error = socketError;

    } on Error catch(e) {

      print("register fatal error");
      print(e.stackTrace);

      apiResponse.error = e.toString();
    }

    return apiResponse;
  }
}