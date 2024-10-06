import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {

  final String _baseUrl = 'https://www.googleapis.com/books/v1/';

  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> getBooks({required String endpoint}) async {
    var response = await _dio.get('$_baseUrl$endpoint');

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(json.encode(response.data));
      }
    }
    else {
      if (kDebugMode) {
        print(response.statusMessage);
      }
    }
    return response.data;
  }
}