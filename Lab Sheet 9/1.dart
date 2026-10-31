import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Practical 1: Parse JSON array into Student objects using fromJson
class Student {
  final int id; final String name; final String email;
  Student({required this.id, required this.name, required this.email});
  factory Student.fromJson(Map<String, dynamic> json) => Student(
    id: json['id'], name: json['name'], email: json['email']);
}
void main() {
  const data = '[{"id":1,"name":"Aman","email":"aman@example.com"},{"id":2,"name":"Riya","email":"riya@example.com"}]';
  final List<dynamic> decoded = jsonDecode(data);
  final students = decoded.map((e) => Student.fromJson(e)).toList();
  for (final s in students) { print('${s.id} ${s.name} ${s.email}'); }
}
