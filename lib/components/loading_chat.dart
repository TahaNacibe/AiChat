import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget loadingChat() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 250),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.grey.shade500,
            ),
            child: LoadingAnimationWidget.waveDots(
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
