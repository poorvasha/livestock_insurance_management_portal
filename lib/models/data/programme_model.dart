import 'package:lsi_management_portal/models/data/state_model.dart';

class Programme {
  String? sId;
  String? name;
  String? code;
  String? state;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Programme(
      {this.sId,
      this.name,
      this.code,
      this.state,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Programme.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    state = json['state'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    if (this.state != null) {
      data['state'] = this.state;
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
