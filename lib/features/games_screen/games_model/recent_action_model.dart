
class RecentAction {
  String playerName;
  String action;
  

  RecentAction({required this.playerName, required this.action});

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'action': action,
      
    };
  }

  static RecentAction fromJson(Map<String, dynamic> json) {
    return RecentAction(
      playerName: json['playerName'],
      action: json['action'],
      
    );
  }
}




