class GroupData {
  final String timeRange;
  final String duration;
  final List<List<String>> players;
  final List<List<String>> restplayers;

  GroupData({
    required this.timeRange,
    required this.duration,
    required this.players,
    required this.restplayers,
  });
}



class CalculateTimeModel {
  String? timeSegment;
  String? duration;
  List<String>? activePlayers;
  List<String>? restingPlayers;

  CalculateTimeModel(
      {this.timeSegment,
      this.duration,
      this.activePlayers,
      this.restingPlayers});

  CalculateTimeModel.fromJson(Map<String, dynamic> json) {
    timeSegment = json['timeSegment'];
    duration = json['duration'];
    activePlayers = json['activePlayers'] is List
        ? List<String>.from(json['activePlayers'])
        : [];
    restingPlayers = json['restingPlayers'] is List
        ? List<String>.from(json['restingPlayers'])
        : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timeSegment'] = timeSegment;
    data['duration'] = duration;
    data['activePlayers'] = activePlayers;
    data['restingPlayers'] = restingPlayers;
    return data;
  }
}