import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lsi_management_portal/models/data/cluster_model.dart';
import 'package:lsi_management_portal/models/data/group_model.dart';
import 'package:lsi_management_portal/models/data/livestock_model.dart';
import 'package:lsi_management_portal/models/data/location_model.dart';
import 'package:lsi_management_portal/models/data/member_model.dart';
import 'package:lsi_management_portal/models/data/programme_model.dart';
import 'package:lsi_management_portal/models/data/region_model.dart';
import 'package:lsi_management_portal/models/data/state_model.dart';

import '../configs/api_routes.dart';
import '../utils/app_exception.dart';

import '../utils/http_client.dart';

class MasterDataService {
  static createState(String name, String code) async {
    var url = ApiRoutes.statesBase;
    try {
      var payload = json.encode({'name': name, 'code': code});
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editState(String name, String code, String id) async {
    var url = "${ApiRoutes.statesBase}/$id";
    try {
      var payload = json.encode({'name': name, 'code': code});
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteState(String id) async {
    var url = "${ApiRoutes.statesBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<States>> getStates() async {
    var url = ApiRoutes.statesBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return States.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createProgramme(String name, String code, String state) async {
    var url = ApiRoutes.programmeBase;
    try {
      var payload = json.encode({'name': name, 'code': code, 'state': state});
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Programme>> getPrograms() async {
    var url = ApiRoutes.programmeBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Programme.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editProgramme(
      String name, String code, String state, String id) async {
    var url = "${ApiRoutes.programmeBase}/$id";
    try {
      var payload = json.encode({'name': name, 'code': code, 'state': state});
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteProgramme(String id) async {
    var url = "${ApiRoutes.programmeBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createRegion(
      String name, String code, String state, String programme) async {
    var url = ApiRoutes.regionBase;
    try {
      var payload = json.encode(
          {'name': name, 'code': code, 'state': state, 'programme': programme});
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Region>> getRegions() async {
    var url = ApiRoutes.regionBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Region.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editRegion(String name, String code, String state, String programme,
      String id) async {
    var url = "${ApiRoutes.regionBase}/$id";
    try {
      var payload = json.encode(
          {'name': name, 'code': code, 'state': state, 'programme': programme});
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteRegion(String id) async {
    var url = "${ApiRoutes.regionBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createLocation(String name, String code, String state,
      String programme, String region) async {
    var url = ApiRoutes.locationBase;
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region
      });
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Location>> getLocations() async {
    var url = ApiRoutes.locationBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Location.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editLocation(String name, String code, String state, String programme,
      String region, String id) async {
    var url = "${ApiRoutes.locationBase}/$id";
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region
      });
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteLocation(String id) async {
    var url = "${ApiRoutes.locationBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createCluster(String name, String code, String state, String programme,
      String region, String location) async {
    var url = ApiRoutes.clusterBase;
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location
      });
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Cluster>> getClusters() async {
    var url = ApiRoutes.clusterBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Cluster.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editCluster(String name, String code, String state, String programme,
      String region, String location, String id) async {
    var url = "${ApiRoutes.clusterBase}/$id";
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location
      });
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteCluster(String id) async {
    var url = "${ApiRoutes.clusterBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createGroup(String name, String code, String state, String programme,
      String region, String location, String cluster) async {
    var url = ApiRoutes.groupBase;
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location,
        'cluster': cluster
      });
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Group>> getGroups() async {
    var url = ApiRoutes.groupBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Group.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editGroup(String name, String code, String state, String programme,
      String region, String location, String cluster, String id) async {
    var url = "${ApiRoutes.groupBase}/$id";
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location,
        'cluster': cluster
      });
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteGroup(String id) async {
    var url = "${ApiRoutes.groupBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createMember(String name, String code, String state, String programme,
      String region, String location, String cluster, String group) async {
    var url = ApiRoutes.memberBase;
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location,
        'cluster': cluster,
        'group': group
      });
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Member>> getMembers() async {
    var url = ApiRoutes.memberBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Member.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editMember(
      String name,
      String code,
      String state,
      String programme,
      String region,
      String location,
      String cluster,
      String group,
      String id) async {
    var url = "${ApiRoutes.memberBase}/$id";
    try {
      var payload = json.encode({
        'name': name,
        'code': code,
        'state': state,
        'programme': programme,
        'region': region,
        'location': location,
        'cluster': cluster,
        'group': group
      });
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteMember(String id) async {
    var url = "${ApiRoutes.memberBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static createLivestock(String name, String code) async {
    var url = ApiRoutes.livestockBase;
    try {
      var payload = json.encode({'name': name, 'code': code});
      var response = await HttpClient.post(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static Future<List<Livestock>> getLivestocks() async {
    var url = ApiRoutes.livestockBase;
    try {
      var response = await HttpClient.get(url);
      return (response as List).map((dynamic item) {
        return Livestock.fromJson(item);
      }).toList();
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static editLivestock(String name, String code, String id) async {
    var url = "${ApiRoutes.livestockBase}/$id";
    try {
      var payload = json.encode({'name': name, 'code': code});
      var response = await HttpClient.patch(url, payload);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }

  static deleteLivestock(String id) async {
    var url = "${ApiRoutes.livestockBase}/$id";
    try {
      var response = await HttpClient.delete(url);
      return response;
    } on SocketException {
      throw FetchDataException('No Internet Connection', url.toString());
    } on TimeoutException {
      throw ApiNotRespondingException(
          'API not responded in Time', url.toString());
    }
  }
}
