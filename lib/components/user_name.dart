import 'package:flutter/material.dart';

Widget userName({String name = "User"}) {
  //* display
  String firstLetter = name[0].toUpperCase();

  //* ui tree
  return Text(
    " ${firstLetter + name.substring(1)}",
    style: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black,
    ),
  );
}