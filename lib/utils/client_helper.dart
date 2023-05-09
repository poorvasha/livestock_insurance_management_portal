import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../services/SecureStorageService.dart';
import 'app_exception.dart';
import 'dialog_helper.dart';

class ClientHelper {
  static Future<Map<String, String>> getClientHeader(
      {bool authenticationRequired = true}) async {
    try {
      var header = {HttpHeaders.contentTypeHeader: "application/json"};
      if (authenticationRequired) {
        var authToken = await SecureStorage().readSecureData('accessToken');
        header["Authorization"] = "Bearer ${authToken.toString()}";
      }
      return header;
    } on Exception catch (e) {
      return {};
    }
  }

  static dynamic processResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = utf8.decode(response.bodyBytes);
        return json.decode(responseJson);
      case 201:
        var responseJson = utf8.decode(response.bodyBytes);
        return json.decode(responseJson);
      case 204:
        return "";
      case 400:
        String result = utf8.decode(response.bodyBytes);
        Map<String, dynamic> decodedResult = json.decode(result);
        throw BadRequestException(
            decodedResult['message'], response.request?.url.toString());
      case 401:
        throw FetchDataException(
            'Error occured with a statuscode : ${response.statusCode}',
            response.request?.url.toString());
      case 403:
        throw UnAuthorizedException(
            utf8.decode(response.bodyBytes), response.request?.url.toString());
      case 404:
        throw ApiNotFoundException(
            'API Not Found', response.request?.url.toString());
      case 500:
        throw FetchDataException(
            'Error occured with a statuscode : ${response.statusCode}',
            response.request?.url.toString());
      default:
        throw FetchDataException(
            'Error occured with a statuscode : ${response.statusCode}',
            response.request?.url.toString());
    }
  }

  dynamic handleResponseError(BuildContext context, error) {
    DialogHelper().hideLoading(context);
    if (error is BadRequestException) {
      var resMessage = json.decode(error.message.toString());
      DialogHelper()
          .showErrorDialog(context, description: resMessage["message"]);
    } else if (error is ApiNotRespondingException) {
      var resMessage = json.decode(error.message.toString());
      DialogHelper()
          .showErrorDialog(context, description: resMessage["message"]);
    } else if (error is FetchDataException) {
      var resMessage = json.decode(error.message.toString());
      DialogHelper()
          .showErrorDialog(context, description: resMessage["message"]);
    } else if (error is UnAuthorizedException) {
      var resMessage = json.decode(error.message.toString());
      DialogHelper()
          .showErrorDialog(context, description: resMessage["message"]);
    } else if (error is ApiNotFoundException) {
      var resMessage = json.decode(error.message.toString());
      DialogHelper()
          .showErrorDialog(context, description: resMessage["message"]);
    }
  }
}
