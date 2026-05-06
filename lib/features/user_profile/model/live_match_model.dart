class LiveMatchModel {
  String? id;
  String? location;
  String? date;
  String? time;
  int? duration;
  String? rotation;
  String? opponentTeam;
  String? opponentGoals;
  String? totalGoals;
  String? profileId;
  String? clubName;
  String? logoUrl;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? matchStatus;
  String? remainingDuration;
  String? remainingDurationMinutes;

  LiveMatchModel({
    this.id,
    this.location,
    this.date,
    this.time,
    this.duration,
    this.rotation,
    this.opponentTeam,
    this.opponentGoals,
    this.totalGoals,
    this.profileId,
    this.clubName,
    this.logoUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.matchStatus,
    this.remainingDuration,
    this.remainingDurationMinutes,
  });

  // A factory constructor to create a model from JSON data
  factory LiveMatchModel.fromJson(Map<String, dynamic> json) {
    return LiveMatchModel(
      id: json['id'],
      location: json['location'],
      date: json['date'],
      time: json['time'],
      duration: json['duration'],
      rotation: json['rotation']?.toString(),
      opponentTeam: json['opponentTeam'],
      opponentGoals: json['opponentGoals']?.toString(),
      totalGoals: json['totalGoals']?.toString(),
      profileId: json['profileId'],
      clubName: json['clubName'],
      logoUrl: json['logoUrl'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      matchStatus: json['matchStatus'],
      remainingDuration: json['remainingDuration'],
      remainingDurationMinutes: json['remainingDurationMinutes']?.toString(),
    );
  }
}
