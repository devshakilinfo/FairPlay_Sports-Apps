// import 'package:intl/intl.dart';
// import 'package:sports_apps/core/utils/constants/icon_path.dart';

// class MatchData {
//   final String team1Logo;
//   final String team1Name;
//   final String team2Logo;
//   final String team2Name;
//   final String date;
//   final String time;

//   MatchData({
//     required this.team1Logo,
//     required this.team1Name,
//     required this.team2Logo,
//     required this.team2Name,
//     required this.date,
//     required this.time,
//   });

//   factory MatchData.fromJson(Map<String, dynamic> json) {
//     return MatchData(
//       team1Logo: json['logoUrl'] ?? IconPath.clublogo,
//       team1Name: json['clubName'] ?? 'RM',
//       team2Logo: json['logoUrl'] ?? IconPath.cbflogo,
//       team2Name: json['opponentTeam'] ?? 'FCB',
//       date: formatDate(json['date'] ?? ''),
//       time: json['time'] ?? '',
//     );
//   }

//   static DateTime parseDateTime(String dateStr) {
//     try {
//       // If dateStr has time zone info like "Z" at the end, use DateTime.parse() which handles it.
//       return DateTime.parse(dateStr);
//     } catch (e) {
//       return DateTime.now();
//     }
//   }

//   static String formatDate(String dateStr) {
//     if (dateStr.isEmpty) return '';

//     try {
//       DateTime dateTime = parseDateTime(dateStr);
//       return DateFormat('yyyy-MM-dd').format(dateTime);
//     } catch (e) {
//       return dateStr;
//     }
//   }

//   String getRemainingTime() {
//     DateTime matchDateTime = parseDateTime(date);

//     // Ensure the time zone is considered when comparing with current time
//     DateTime matchTimeWithCurrentDate = DateTime(
//       matchDateTime.year,
//       matchDateTime.month,
//       matchDateTime.day,
//       int.parse(time.split(":")[0]), // Extract hour from time string
//       int.parse(
//         time.split(":")[1].split(" ")[0],
//       ), // Extract minute from time string
//     );

//     // Calculate the remaining duration between current time and match time
//     Duration remainingDuration =
//         matchTimeWithCurrentDate.isAfter(DateTime.now())
//             ? matchTimeWithCurrentDate.difference(DateTime.now())
//             : Duration.zero;

//     if (remainingDuration.isNegative) {
//       return "Match has passed";
//     } else if (remainingDuration.inDays > 0) {
//       return 'In ${remainingDuration.inDays} days';
//     } else if (remainingDuration.inHours > 0) {
//       return '${remainingDuration.inHours} hour(s) left';
//     } else if (remainingDuration.inMinutes > 0) {
//       return '${remainingDuration.inMinutes} minute(s) left';
//     } else {
//       return 'Starting soon';
//     }
//   }
// }





import 'package:intl/intl.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';

class MatchData {
  final String team1Logo;
  final String team1Name;
  final String team2Logo;
  final String team2Name;
  final String date;
  final String time;

  MatchData({
    required this.team1Logo,
    required this.team1Name,
    required this.team2Logo,
    required this.team2Name,
    required this.date,
    required this.time,
  });

  factory MatchData.fromJson(Map<String, dynamic> json) {
    return MatchData(
      team1Logo: json['logoUrl'] ?? IconPath.clublogo,
      team1Name: json['clubName'] ?? 'RM',
      team2Logo: json['logoUrl'] ?? IconPath.cbflogo,
      team2Name: json['opponentTeam'] ?? 'FCB',
      date: formatDate(json['date'] ?? ''),
      time: json['time'] ?? '',
    );
  }

  static DateTime parseDateTime(String dateStr) {
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      return DateTime.now();
    }
  }

  static String formatDate(String dateStr) {
    if (dateStr.isEmpty) return '';

    try {
      DateTime dateTime = parseDateTime(dateStr);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return dateStr;
    }
  }

  String getRemainingTime() {
    DateTime matchDateTime = parseDateTime(date);

    // Ensure the time zone is considered when comparing with current time
    DateTime matchTimeWithCurrentDate = DateTime(
      matchDateTime.year,
      matchDateTime.month,
      matchDateTime.day,
      int.parse(time.split(":")[0]),
      int.parse(time.split(":")[1].split(" ")[0]),
    );

    Duration remainingDuration =
        matchTimeWithCurrentDate.isAfter(DateTime.now())
            ? matchTimeWithCurrentDate.difference(DateTime.now())
            : Duration.zero;

    if (remainingDuration.isNegative) {
      return "Match has passed";
    } else if (remainingDuration.inDays > 0) {
      return 'In ${remainingDuration.inDays} days';
    } else if (remainingDuration.inHours > 0) {
      return '${remainingDuration.inHours} hour(s) left';
    } else if (remainingDuration.inMinutes > 0) {
      return '${remainingDuration.inMinutes} minute(s) left';
    } else {
      return 'Starting soon';
    }
  }
}
