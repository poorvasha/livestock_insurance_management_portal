import 'programme_model.dart';
import 'state_model.dart';

class Region {
  String? sId;
  String? name;
  String? code;
  String? state;
  String? programme;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Region(
      {this.sId,
      this.name,
      this.code,
      this.state,
      this.programme,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Region.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    state = json['state'];
    programme = json['programme'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['code'] = code;
    if (state != null) {
      data['state'] = state;
    }
    if (programme != null) {
      data['programme'] = programme;
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}
