import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const String IP = '192.168.0.127';

class Api {
  static const String API_PREFIX = 'http://$IP:8000/api';

  static Future<List<Object>> getObjects(String searchTerm) async {
    final url = Uri.parse('$API_PREFIX/objects?name=$searchTerm');

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes); // Декодируем байты в строку
        final Map<String, dynamic> data = json.decode(decodedResponse); // Декодируем JSON из строки

        final List<dynamic> objectsJson = data['data'];
        return objectsJson.map((item) => Object.fromJson(item)).toList();
      } else {
        throw Exception('Ошибка при получении данных с сервера');
      }
    } catch (error) {
      print("Ошибка: $error");
      return [];
    }
  }


  static Future<Object?> getObject(String id) async {
    final url = Uri.parse('$API_PREFIX/objects/$id');

    try {
      final response = await http.get(url, headers: {'Content-Type': 'application/json; charset=UTF-8'});

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        final data = json.decode(decodedResponse);

        return Object.fromJson(data);
      } else {
        throw Exception('Ошибка при получении данных с сервера');
      }
    } catch (error) {
      print("Ошибка: $error");
      return null;
    }
  }
}

class Object {
  final int id;
  final String name;
  final String image;
  final String description;

  Object({required this.id, required this.name, required this.image, required this.description});

  // Фабричный метод для создания объекта из JSON
  factory Object.fromJson(Map<String, dynamic> json) {
    return Object(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      description: json['description'] as String,
    );
  }
}
