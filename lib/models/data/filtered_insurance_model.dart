class FilteredInsurance {
  String? cluster;
  String? group;
  String? member;
  String? livestock;
  String? variety;
  int? cost;
  int? premiumAmount;
  int? sumAssured;
  int? tagNumber;
  String? enrolledDate;
  int? coveringPeriod;
  String? imageFront;
  String? imageBack;
  String? imageLeft;
  String? imageRight;

  FilteredInsurance(
      {this.cluster,
      this.group,
      this.member,
      this.livestock,
      this.variety,
      this.cost,
      this.premiumAmount,
      this.sumAssured,
      this.tagNumber,
      this.enrolledDate,
      this.coveringPeriod,
      this.imageFront,
      this.imageBack,
      this.imageLeft,
      this.imageRight});

  FilteredInsurance.fromJson(Map<String, dynamic> json) {
    cluster = json['cluster'];
    group = json['group'];
    member = json['member'];
    livestock = json['livestock'];
    variety = json['variety'];
    cost = json['cost'];
    premiumAmount = json['premiumAmount'];
    sumAssured = json['sumAssured'];
    tagNumber = json['tagNumber'];
    enrolledDate = json['enrolledDate'];
    coveringPeriod = json['coveringPeriod'];
    imageFront = json['imageFront'];
    imageBack = json['imageBack'];
    imageLeft = json['imageLeft'];
    imageRight = json['imageRight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cluster'] = this.cluster;
    data['group'] = this.group;
    data['member'] = this.member;
    data['livestock'] = this.livestock;
    data['variety'] = this.variety;
    data['cost'] = this.cost;
    data['premiumAmount'] = this.premiumAmount;
    data['sumAssured'] = this.sumAssured;
    data['tagNumber'] = this.tagNumber;
    data['enrolledDate'] = this.enrolledDate;
    data['coveringPeriod'] = this.coveringPeriod;
    data['imageFront'] = this.imageFront;
    data['imageBack'] = this.imageBack;
    data['imageLeft'] = this.imageLeft;
    data['imageRight'] = this.imageRight;
    return data;
  }
}
