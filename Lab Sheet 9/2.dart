import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 2: Demonstrate Future async and await
Future<String> getMessage() async {
  await Future.delayed(const Duration(seconds: 2));
  return 'Data received after 2 seconds';
}
Future<void> main() async {
  print('Please wait...');
  final message = await getMessage();
  print(message);
}
