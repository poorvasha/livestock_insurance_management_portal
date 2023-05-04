import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'client_helper.dart';

class HttpClient {
  static post(String url, dynamic payload,
      {bool isAuthenticationRequired = true}) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.post(uri,
        body: payload,
        headers: await ClientHelper.getClientHeader(
            authenticationRequired: isAuthenticationRequired));
    return ClientHelper.processResponse(response);
  }

  static get(String url,
      {bool isAuthenticationRequired = true, Uri? uri = null}) async {
    var client = http.Client();
    var currentUri = uri ?? Uri.parse(url);
    var response = await client.get(currentUri,
        headers: await ClientHelper.getClientHeader(
            authenticationRequired: isAuthenticationRequired));
    return ClientHelper.processResponse(response);
  }

  static put(String url, dynamic payload,
      {bool isAuthenticationRequired = true}) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.put(uri,
        body: payload,
        headers: await ClientHelper.getClientHeader(
            authenticationRequired: isAuthenticationRequired));
    return ClientHelper.processResponse(response);
  }

  static patch(String url, dynamic payload,
      {bool isAuthenticationRequired = true}) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.patch(uri,
        body: payload,
        headers: await ClientHelper.getClientHeader(
            authenticationRequired: isAuthenticationRequired));
    return ClientHelper.processResponse(response);
  }

  static delete(String url, {bool isAuthenticationRequired = true}) async {
    var client = http.Client();
    var uri = Uri.parse(url);
    var response = await client.delete(uri,
        headers: await ClientHelper.getClientHeader(
            authenticationRequired: isAuthenticationRequired));
    return ClientHelper.processResponse(response);
  }
}
