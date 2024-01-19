import 'package:flutter/material.dart';

Widget errorMessage(String message) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Icon(
        Icons.warning_amber_rounded,
        size: 150,
      ),
      const SizedBox(width: 5),
      Text(
        message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  ));
}
