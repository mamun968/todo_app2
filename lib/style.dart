import 'package:flutter/material.dart';

InputDecoration appTextField(labelTest) {
  return InputDecoration(
    labelText: labelTest,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 68, 192, 245),
  );
}
