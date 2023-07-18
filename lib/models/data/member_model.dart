class Member {
  String? sId;
  String? name;
  String? code;
  String? state;
  String? programme;
  String? region;
  String? location;
  String? cluster;
  String? group;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Member(
      {this.sId,
      this.name,
      this.code,
      this.state,
      this.programme,
      this.region,
      this.location,
      this.cluster,
      this.group,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Member.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    state = json['state'];
    programme = json['programme'];
    region = json['region'];
    location = json['location'];
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
    data['state'] = this.state;
    data['programme'] = this.programme;
    data['region'] = this.region;
    data['location'] = this.location;
    data['cluster'] = this.cluster;
    data['group'] = this.group;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
