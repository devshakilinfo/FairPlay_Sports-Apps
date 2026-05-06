class ProfileModel {
  String? message;
  UserData? user;

  ProfileModel({this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? role;
  bool? isVerified;
  String? otp;
  String? profileId;
  String? clubName;
  String? teamName;
  String? city;
  String? country;
  String? logoUrl;
  String? coachName;
  List<Players>? players;
  List<dynamic>? plans;
  List<dynamic>? payments;

  UserData({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.role,
    this.isVerified,
    this.otp,
    this.profileId,
    this.clubName,
    this.teamName,
    this.city,
    this.country,
    this.logoUrl,
    this.coachName,
    this.players,
    this.plans,
    this.payments,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    isVerified = json['isVerified'];
    otp = json['otp'];
    profileId = json['profileId'];
    clubName = json['clubName'];
    teamName = json['teamName'];
    city = json['city'];
    country = json['country'];
    logoUrl = json['logoUrl'];
    coachName = json['coachName'];
    if (json['players'] != null) {
      players =
          (json['players'] as List).map((v) => Players.fromJson(v)).toList();
    }
    plans = json['plans'];
    payments = json['payments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['role'] = role;
    data['isVerified'] = isVerified;
    data['otp'] = otp;
    data['profileId'] = profileId;
    data['clubName'] = clubName;
    data['teamName'] = teamName;
    data['city'] = city;
    data['country'] = country;
    data['logoUrl'] = logoUrl;
    data['coachName'] = coachName;
    if (players != null) {
      data['players'] = players!.map((v) => v.toJson()).toList();
    }
    data['plans'] = plans;
    data['payments'] = payments;
    return data;
  }
}

class Players {
  String? id;
  String? name;
  int? birthYear;
  String? position;
  String? preferredFoot;
  bool? isSelected;
  String? profileId;
  String? createdAt;
  String? updatedAt;

  Players({
    this.id,
    this.name,
    this.birthYear,
    this.position,
    this.preferredFoot,
    this.isSelected,
    this.profileId,
    this.createdAt,
    this.updatedAt,
  });

  Players.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthYear = json['birthYear'];
    position = json['position'];
    preferredFoot = json['preferredFoot'];
    isSelected = json['isSelected'];
    profileId = json['profileId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['birthYear'] = birthYear;
    data['position'] = position;
    data['preferredFoot'] = preferredFoot;
    data['isSelected'] = isSelected;
    data['profileId'] = profileId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


class UserProfile {
  final String name;
  final String clubName;
  final String email;
  final String country;
  final String city;
  final String logoUrl;
  final String planName;
  final String profileId;

  UserProfile({
    required this.name,
    required this.clubName,
    required this.email,
    required this.country,
    required this.city,
    required this.logoUrl,
    required this.planName,
    required this.profileId,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    final List<dynamic> plans = json["plans"] ?? [];
    return UserProfile(
      name: json["coachName"] ?? '',
      clubName: json["clubName"] ?? '',
      email: json["email"] ?? '',
      country: json["country"] ?? '',
      city: json["city"] ?? '',
      logoUrl: json["logoUrl"] ?? '',
      profileId: json["profileId"] ?? "",
      planName: plans.isNotEmpty ? plans[0]["name"] : 'No Plan',
      
    );
  }
}
