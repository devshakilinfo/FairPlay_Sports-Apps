class LastMatchResponse {
  final String message;
  final LastMatch? lastMatch; // Nullable field

  LastMatchResponse({required this.message, this.lastMatch});

  factory LastMatchResponse.fromJson(Map<String, dynamic> json) {
    return LastMatchResponse(
      message:
          json['message'] ??
          '', // Provide default empty string if message is null
      lastMatch:
          json['lastMatch'] != null
              ? LastMatch.fromJson(json['lastMatch'])
              : null, // Handle nullable field
    );
  }
}

class LastMatch {
  final String id;
  final String location;
  final DateTime? date;
  final String? time;
  final String? clubName;
  final String? opponentTeam;
  final String? logoUrl;
  final String? status;
  final int? totalGoals;
  final int? opponentGoals;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LastMatch({
    required this.id,
    required this.location,
    this.date,
    this.time,
    this.clubName,
    this.opponentTeam,
    this.logoUrl,
    this.status,
    this.totalGoals,
    this.opponentGoals,
    this.createdAt,
    this.updatedAt,
  });

  factory LastMatch.fromJson(Map<String, dynamic> json) {
    return LastMatch(
      id: json['id'] ?? '',
      location: json['location'] ?? '',
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      time: json['time'],
      clubName: json['clubName'],
      opponentTeam: json['opponentTeam'],
      logoUrl: json['logoUrl'],
      status: json['status'],
      totalGoals: json['totalGoals'],
      opponentGoals: json['opponentGoals'],
      createdAt:
          json['createdAt'] != null
              ? DateTime.tryParse(json['createdAt'])
              : null,
      updatedAt:
          json['updatedAt'] != null
              ? DateTime.tryParse(json['updatedAt'])
              : null,
    );
  }
}
