import 'package:flutter/material.dart';
final ValueNotifier<int> focusedButtonIndex = ValueNotifier<int>(0);
Row combinebutton() {
    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            focusedButtonIndex.value = 0;
                          },
                          child: ValueListenableBuilder<int>(
                            valueListenable: focusedButtonIndex,
                            builder: (context, value, child) {
                              return Container(
                                height: 34,
                                width: 100,
                                decoration: BoxDecoration(
                                  color:
                                      value == 0
                                          ? Color(0xff00BA0B)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Recent",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          value == 0
                                              ? Colors.white
                                              : Color(0xff00BA0B),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            focusedButtonIndex.value = 1;
                          },
                          child: ValueListenableBuilder<int>(
                            valueListenable: focusedButtonIndex,
                            builder: (context, value, child) {
                              return Container(
                                height: 34,
                                width: 100,
                                decoration: BoxDecoration(
                                  color:
                                      value == 1
                                          ? Color(0xff00BA0B)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Form",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          value == 1
                                              ? Colors.white
                                              : Color(0xff00BA0B),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            focusedButtonIndex.value = 2;
                          },
                          child: ValueListenableBuilder<int>(
                            valueListenable: focusedButtonIndex,
                            builder: (context, value, child) {
                              return Container(
                                height: 34,
                                width: 100,
                                decoration: BoxDecoration(
                                  color:
                                      value == 2
                                          ? Color(0xff00BA0B)
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Stats",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          value == 2
                                              ? Colors.white
                                              : Color(0xff00BA0B),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
  }