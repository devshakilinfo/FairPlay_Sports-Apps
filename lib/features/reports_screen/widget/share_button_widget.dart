import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';

Padding sharebutton() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15,right: 20,left: 20,top: 5),
    child: SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Color(0xff00BA0B), 
            borderRadius: BorderRadius.circular(4), 
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.share, color: Colors.white,size: 20),
              SizedBox(width: 8),
              Text(
                'Share',
                style: globalTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
