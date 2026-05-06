import 'package:flutter/material.dart';
import 'package:sports_apps/core/style/globaltextstyle.dart';
import 'package:sports_apps/core/utils/constants/icon_path.dart';
import 'package:sports_apps/features/games_screen/games_edit_screen.dart';

void showMatchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          child: Container(
            height: 238,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(0xffFFFFFF),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 20,
                        width: 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Color(0xffE6F8E7),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GamesEditScreen(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.edit,
                                size: 9,
                                color: Color(0xff00BA0B),
                              ),
                              Text(
                                "Edit",
                                style: globalTextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff00BA0B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                SizedBox(
                  height: 79,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 87,
                        height: 79,

                        child: Column(
                          children: [
                            Image.asset(
                              IconPath.clublogo,
                              width: 40,
                              height: 54,
                            ),
                            Text(
                              "Real Madrid",
                              style: globalTextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 63,
                        width: 63,

                        child: Column(
                          children: [
                            Text(
                              "4-2",
                              style: globalTextStyle(
                                color: Color(0xff0047AB),
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            Container(
                              height: 22,
                              width: 63,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xffE6F8E7),
                              ),
                              child: Center(
                                child: Text(
                                  "90 Min",
                                  style: globalTextStyle(
                                    color: Color(0xff00BA0B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 79,
                        width: 87,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                IconPath.cbflogo,
                                height: 42,
                                width: 40,
                              ),
                              Text(
                                "girona",
                                style: globalTextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(height: 0.5, indent: 15, endIndent: 15,color: Color(0xffe6edf7),),
                SizedBox(height: 8),
                SizedBox(
                  height: 67,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Vini Jr 8', 65'",
                              style: globalTextStyle(
                                color: Color(0xff898989),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                
                              ),
                              ),
                            Text(
                              "Mbappe 45'",
                              style: globalTextStyle(
                                color: Color(0xff898989),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                
                              ),
                              ),
                            Text(
                              "Belingham 78'",
                              style: globalTextStyle(
                                color: Color(0xff898989),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                
                              ),
                              ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Y.Asprilla 34'",
                              style: globalTextStyle(
                                color: Color(0xff898989),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                
                              ),
                              ),
                            Text(
                              "A. Ruiz 83'",
                              style: globalTextStyle(
                                color: Color(0xff898989),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                
                              ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 17,
                    width: 108,
                    child: Text(
                      "14 Feb 3:00 PM",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff565656),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }