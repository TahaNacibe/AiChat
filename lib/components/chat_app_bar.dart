import 'package:dotted_border/dotted_border.dart';
import 'package:eva/components/pfp_widget.dart';
import 'package:eva/components/user_name.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

PreferredSizeWidget chatPageAppBar(String? pfpImage, String name) {
  //* Constant
  const double appBarHeight = 120;
  const double radius = 8;

  //* Ui Tree
  return PreferredSize(
    preferredSize: Size.fromHeight(appBarHeight),
    child: SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200, width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //* Temporary Chat button
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(3),
                child: Icon(Ionicons.ellipsis_vertical_outline, size: 16),
              ),
            ),
            //* profile widget
            Row(
              children: [
                //* User name
                userName(name: name),

                //* Profile Picture
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: pfpWidget(name, pfpImage),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
