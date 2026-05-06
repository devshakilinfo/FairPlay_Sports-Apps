class AllPlayer {
  String? message;
  List<LineupPlayers>? lineupPlayers;

  AllPlayer({this.message, this.lineupPlayers});

  // Constructor with null safety
  AllPlayer.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['lineupPlayers'] != null) {
      lineupPlayers = <LineupPlayers>[];
      json['lineupPlayers'].forEach((v) {
        lineupPlayers!.add(LineupPlayers.fromJson(v));
      });
    }
  }

  // To JSON with null safety
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (lineupPlayers != null) {
      data['lineupPlayers'] = lineupPlayers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LineupPlayers {
  String? id;
  String? playerId;
  String? matchLineupPlayers;
  Player? player;

  LineupPlayers({this.id, this.playerId, this.matchLineupPlayers, this.player});

  LineupPlayers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playerId = json['playerId'];
    matchLineupPlayers = json['matchLineupPlayers'];
    player = json['player'] != null ? Player.fromJson(json['player']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playerId'] = playerId;
    data['matchLineupPlayers'] = matchLineupPlayers;
    if (player != null) {
      data['player'] = player!.toJson();
    }
    return data;
  }
}

class Player {
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
  List<MatchStat>? matchStats; // Changed this to List<MatchStat>

  Player({
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
    this.matchStats,
  });

  Player.fromJson(Map<String, dynamic> json) {
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

    if (json['matchStats'] != null) {
      matchStats = <MatchStat>[];
      json['matchStats'].forEach((v) {
        matchStats!.add(MatchStat.fromJson(v));
      });
    }
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
    data['totalGoals'] = totalGoals;
    data['totalAssists'] = totalAssists;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;

    if (matchStats != null) {
      data['matchStats'] = matchStats!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}


class MatchStat {
  String? id;
  String? matchId;
  String? playerId;
  int? goals;
  int? assists;
  Match? match;

  MatchStat({
    this.id,
    this.matchId,
    this.playerId,
    this.goals,
    this.assists,
    this.match,
  });

  MatchStat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    matchId = json['matchId'];
    playerId = json['playerId'];
    goals = json['goals'];
    assists = json['assists'];
    match = json['match'] != null ? Match.fromJson(json['match']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['matchId'] = matchId;
    data['playerId'] = playerId;
    data['goals'] = goals;
    data['assists'] = assists;
    if (match != null) {
      data['match'] = match!.toJson();
    }
    return data;
  }
}

class Match {
  String? id;
  String? location;
  String? date;
  String? time;
  int? duration;
  String? opponentTeam;
  int? opponentGoals;
  int? totalGoals;
  String? status;
  String? clubName;
  String? logoUrl;

  Match({
    this.id,
    this.location,
    this.date,
    this.time,
    this.duration,
    this.opponentTeam,
    this.opponentGoals,
    this.totalGoals,
    this.status,
    this.clubName,
    this.logoUrl,
  });

  Match.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    duration = json['duration'];
    opponentTeam = json['opponentTeam'];
    opponentGoals = json['opponentGoals'];
    totalGoals = json['totalGoals'];
    status = json['status'];
    clubName = json['clubName'];
    logoUrl = json['logoUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location'] = location;
    data['date'] = date;
    data['time'] = time;
    data['duration'] = duration;
    data['opponentTeam'] = opponentTeam;
    data['opponentGoals'] = opponentGoals;
    data['totalGoals'] = totalGoals;
    data['status'] = status;
    data['clubName'] = clubName;
    data['logoUrl'] = logoUrl;
    return data;
  }
}
