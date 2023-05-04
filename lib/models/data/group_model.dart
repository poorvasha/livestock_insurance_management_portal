class Group {
  String? sId;
  String? name;
  String? code;
  String? state;
  String? programme;
  String? region;
  String? location;
  String? cluster;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Group(
      {this.sId,
      this.name,
      this.code,
      this.state,
      this.programme,
      this.region,
      this.location,
      this.cluster,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Group.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    state = json['state'];
    programme = json['programme'];
    region = json['region'];
    location = json['location'];
    cluster = json['cluster'];
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
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}