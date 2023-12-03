import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lsi_management_portal/models/data/insurance_model.dart';

import '../configs/api_routes.dart';
import '../models/data/filtered_insurance_model.dart';
import '../utils/app_exception.dart';
import '../utils/http_client.dart';

class InsuranceService {
  static Future<List<Insurance>> getInsurances() async {
    var url = "${ApiRoutes.insuranceBase}?expand=true";
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Insurance.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<dynamic> createInsurance(List<FilteredInsurance> insurances) async {
   var baseurl = ApiRoutes.insuranceBase;
    var url = "$baseurl/bulk";
    try {

      String payload = jsonEncode(insurances);
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }
}
