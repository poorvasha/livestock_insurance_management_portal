// ignore_for_file: unnecessary_this

import 'package:lsi_management_portal/models/data/location_model.dart';
import 'package:lsi_management_portal/models/data/programme_model.dart';
import 'package:lsi_management_portal/models/data/region_model.dart';
import 'package:lsi_management_portal/models/data/state_model.dart';

class ExpandedMember {
  String? sId;
  String? name;
  String? code;
  String? password;
  States? state;
  Programme? programme;
  Region? region;
  Location? location;
  String? cluster;
  String? group;
  String? createdAt;
  String? updatedAt;
  int? iV;

  ExpandedMember(
      {this.sId,
      this.name,
      this.code,
      this.password,
      this.state,
      this.programme,
      this.region,
      this.location,
      this.cluster,
      this.group,
      this.createdAt,
      this.updatedAt,
      this.iV});

  ExpandedMember.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    password = json['password'];
    state = json['state'] != null ? States.fromJson(json['state']) : null;
    programme = json['programme'] != null ? Programme.fromJson(json['programme']) : null;
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    cluster = json['cluster'];
    group = json['group'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['password'] = this.password;
    data['state'] = this.state?.toJson();
    data['programme'] = this.programme?.toJson();
    data['region'] = this.region?.toJson();
    data['location'] = this.location?.toJson();
    data['cluster'] = this.cluster;
    data['group'] = this.group;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
