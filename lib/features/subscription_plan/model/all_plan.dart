class AllPlan {
  String? message;
  List<Plans>? plans;

  AllPlan({this.message, this.plans});

  AllPlan.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['plans'] != null) {
      plans = <Plans>[];
      json['plans'].forEach((v) {
        plans!.add(Plans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = message;
    if (plans != null) {
      data['plans'] = plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plans {
  String? id;
  String? name;
  int? priceMonthly;
  int? priceYearly;
  String? features;
  String? createdAt;
  String? updatedAt;

  Plans({
    this.id,
    this.name,
    this.priceMonthly,
    this.priceYearly,
    this.features,
    this.createdAt,
    this.updatedAt,
  });

  Plans.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priceMonthly = json['priceMonthly'];
    priceYearly = json['priceYearly'];
    features = json['features'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['priceMonthly'] = priceMonthly;
    data['priceYearly'] = priceYearly;
    data['features'] = features;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
