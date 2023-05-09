class Livestock {
  String? sId;
  String? name;
  String? code;
  String? variety;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Livestock(
      {this.sId,
      this.name,
      this.code,
      this.variety,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Livestock.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    code = json['code'];
    variety = json['variety'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['code'] = this.code;
    data['variety'] = this.variety;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
