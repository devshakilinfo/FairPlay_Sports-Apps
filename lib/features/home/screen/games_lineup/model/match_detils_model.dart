class MatchDetails {
  final String id;
  final String location;
  String date;  // Changed from final to String to allow modification
  final String time;
  final int duration;
  final String opponentTeam;
  final int opponentGoals;
  final int totalGoals;
  final String profileId;
  final String clubName;
  final String? logoUrl;
  final String status;
  final String matchStatus;
  final String remainingDuration;
  final int remainingDurationMinutes;

  MatchDetails({
    required this.id,
    required this.location,
    required this.date,  // Raw date string is stored here
    required this.time,
    required this.duration,
    required this.opponentTeam,
    required this.opponentGoals,
    required this.totalGoals,
    required this.profileId,
    required this.clubName,
    required this.logoUrl,
    required this.status,
    required this.matchStatus,
    required this.remainingDuration,
    required this.remainingDurationMinutes,
  });

  // Factory method to convert JSON into MatchDetails object
  factory MatchDetails.fromJson(Map<String, dynamic> json) {
    return MatchDetails(
      id: json['id'],
      location: json['location'],
      date: json['date'],  // Raw date string is stored here
      time: json['time'],
      duration: json['duration'],
      opponentTeam: json['opponentTeam'],
      opponentGoals: json['opponentGoals'],
      totalGoals: json['totalGoals'],
      profileId: json['profileId'],
      clubName: json['clubName'],
      logoUrl: json['logoUrl'],
      status: json['status'],
      matchStatus: json['matchStatus'],
      remainingDuration: json['remainingDuration'],
      remainingDurationMinutes: json['remainingDurationMinutes'],
    );
  }
}
