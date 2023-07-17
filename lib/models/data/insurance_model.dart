import 'package:lsi_management_portal/models/data/cluster_model.dart';
import 'package:lsi_management_portal/models/data/expanded_member.dart';
import 'package:lsi_management_portal/models/data/group_model.dart';
import 'package:lsi_management_portal/models/data/livestock_model.dart';
import 'package:lsi_management_portal/models/data/member_model.dart';

enum InsuranceStatus { notDetermined, active, expired }

class Insurance {
  String? sId;
  Cluster? cluster;
  Group? group;
  Livestock? livestock;
  double? cost;
  double? premiumAmount;
  double? sumAssured;
  String? tagNumber;
  DateTime? enrolledDate;
  int? coveringPeriod;
  Images? image;
  ExpandedMember? member;
  InsuranceStatus status = InsuranceStatus.notDetermined;
  int renewalDays = -1;

  Insurance(
      {this.sId,
      this.cluster,
      this.group,
      this.livestock,
      this.cost,
      this.premiumAmount,
      this.sumAssured,
      this.tagNumber,
      this.enrolledDate,
      this.coveringPeriod,
      this.image,
      this.member});

  Insurance.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cluster = Cluster.fromJson(json['cluster']);
    group = Group.fromJson(json['group']);
    livestock = Livestock.fromJson(json['livestock']);
    cost = json['cost'];
    premiumAmount = json['premiumAmount'];
    sumAssured = json['sumAssured'];
    tagNumber = json['tagNumber'];
    enrolledDate = json['enrolledDate'] != null
        ? DateTime.parse(json['enrolledDate'])
        : null;
    coveringPeriod = json['coveringPeriod'];
    image = json['image'] != null ? Images.fromJson(json['image']) : null;
    member = ExpandedMember.fromJson(json['member']);

    if (enrolledDate != null && coveringPeriod != null) {
      DateTime expiryDate =
          enrolledDate!.add(Duration(days: coveringPeriod! * 28));
      renewalDays = expiryDate.difference(DateTime.now()).inDays;
      status =
          renewalDays >= 0 ? InsuranceStatus.active : InsuranceStatus.expired;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['cluster'] = cluster?.toJson();
    data['group'] = group?.toJson();
    data['livestock'] = livestock?.toJson();
    data['cost'] = cost;
    data['premiumAmount'] = premiumAmount;
    data['sumAssured'] = sumAssured;
    data['tagNumber'] = tagNumber;
    data['enrolledDate'] = enrolledDate;
    data['coveringPeriod'] = coveringPeriod;
    if (image != null) {
      data['image'] = image!.toJson();
    }
    data['member'] = member?.toJson();
    return data;
  }
}

class Images {
  String? front;
  String? back;
  String? left;
  String? right;
  String? sId;

  Images({this.front, this.back, this.left, this.right, this.sId});

  Images.fromJson(Map<String, dynamic> json) {
    front = json['front'];
    back = json['back'];
    left = json['left'];
    right = json['right'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['front'] = front;
    data['back'] = back;
    data['left'] = left;
    data['right'] = right;
    data['_id'] = sId;
    return data;
  }
}
