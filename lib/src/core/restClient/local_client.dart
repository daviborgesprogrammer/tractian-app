import 'dart:convert';

import 'package:flutter/services.dart';

class LocalClient {
  final String baseUrl;
  LocalClient() : baseUrl = 'assets/json/api-data.json';

  Future<List<dynamic>> get(String property, [String? subProperty]) async {
    final String response = await rootBundle.loadString(baseUrl);
    final data = await json.decode(response);
    return subProperty != null && subProperty.isNotEmpty
        ? data[property][subProperty]
        : data[property];
  }
}
