import 'package:flutter/material.dart';
import '../../../core/style/globaltextstyle.dart' show globalTextStyle;

class PlayerSetupWidget extends StatelessWidget {
  final String playerName;
  final String playerRole;
  final String profileImagePath;
  final VoidCallback onEditPressed;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  const PlayerSetupWidget({
    super.key,
    required this.playerName,
    required this.playerRole,
    required this.profileImagePath,
    required this.onEditPressed,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF0047AB), width: 2),
                ),
                child: Image.asset(profileImagePath, fit: BoxFit.cover),
              ),
              Text(
                playerName,
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                playerRole,
                style: globalTextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Positioned(
            top: 18,
            right: 2,
            child: GestureDetector(
              onTap: onEditPressed,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Color(0xFF0047AB), width: 1),
                ),
                child: Center(
                  child: Icon(Icons.edit, size: 8, color: Color(0xFF0047AB)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
