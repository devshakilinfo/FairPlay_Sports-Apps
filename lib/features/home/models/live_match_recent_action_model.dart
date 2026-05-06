class LiveMatchRecentAction {
  String playerName;
  String action;
  String type;

 
  LiveMatchRecentAction({
    required this.type,       
    required this.playerName,
    required this.action,
  });


  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'action': action,
      'type': type,
    };
  }

 
  static LiveMatchRecentAction fromJson(Map<String, dynamic> json) {
    return LiveMatchRecentAction(
      playerName: json['playerName'],
      action: json['action'],
      type: json['type'],
    );
  }
}
