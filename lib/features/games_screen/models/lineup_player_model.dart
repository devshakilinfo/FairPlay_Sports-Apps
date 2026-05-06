class LineupActivePlayer {
  String? id;
  String? name;
  int? birthYear;
  String? position;
  String? preferredFoot;
  bool? isSelected;
  String? profileId;
  int? totalGoals;
  int? totalAssists;
  String? createdAt;
  String? updatedAt;

  LineupActivePlayer({
    this.id,
    this.name,
    this.birthYear,
    this.position,
    this.preferredFoot,
    this.isSelected,
    this.profileId,
    this.totalGoals,
    this.totalAssists,
    this.createdAt,
    this.updatedAt,
  });

  LineupActivePlayer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    birthYear = json['birthYear'];
    position = json['position'];
    preferredFoot = json['preferredFoot'];
    isSelected = json['isSelected'];
    profileId = json['profileId'];
    totalGoals = json['totalGoals'];
    totalAssists = json['totalAssists'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
}
