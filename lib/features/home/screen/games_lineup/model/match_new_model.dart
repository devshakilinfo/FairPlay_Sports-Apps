class MatchNewModel {
  String id;
  String location;
  DateTime date;
  String time;
  int duration;
  int rotation;
  String opponentTeam;
  int opponentGoals;
  int totalGoals;
  String profileId;
  String clubName;
  String? logoUrl;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> selectedPlayers;
  List<dynamic> matchStats;

  MatchNewModel({
    required this.id,
    required this.location,
    required this.date,
    required this.time,
    required this.duration,
    required this.rotation,
    required this.opponentTeam,
    required this.opponentGoals,
    required this.totalGoals,
    required this.profileId,
    required this.clubName,
    required this.logoUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.selectedPlayers,
    required this.matchStats,
  });

  // From JSON constructor with null handling
  factory MatchNewModel.fromJson(Map<String, dynamic> json) {
    return MatchNewModel(
      id: json['id'] ?? '', // Default empty string if null
      location: json['location'] ?? '', // Default empty string if null
      date:
          json['date'] != null
              ? DateTime.parse(json['date'])
              : DateTime.now(), // Use current date if null
      time: json['time'] ?? '', // Default empty string if null
      duration: json['duration'] ?? 0, // Default 0 if null
      rotation: json['rotation'] ?? 0, // Default 0 if null
      opponentTeam: json['opponentTeam'] ?? '', // Default empty string if null
      opponentGoals: json['opponentGoals'] ?? 0, // Default 0 if null
      totalGoals: json['totalGoals'] ?? 0, // Default 0 if null
      profileId: json['profileId'] ?? '', // Default empty string if null
      clubName: json['clubName'] ?? '', // Default empty string if null
      logoUrl: json['logoUrl']?.toString(), // Default empty string if null
      status: json['status'] ?? '', // Default empty string if null
      createdAt:
          json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now(), // Default to current date if null
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'])
              : DateTime.now(), // Default to current date if null
      selectedPlayers: List<dynamic>.from(
        json['selectedPlayers'] ?? [],
      ), // Default empty list if null
      matchStats: List<dynamic>.from(
        json['matchStats'] ?? [],
      ), // Default empty list if null
    );
  }
}
