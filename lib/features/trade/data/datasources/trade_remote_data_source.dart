import 'dart:convert';

import 'package:swafa_app_frontend/features/trade/data/models/trade_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class TradesRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  TradesRemoteDataSource({required this.baseUrl});

  Future<List<TradeModel>> fetchTrades() async {
    String token = await _storage.read(key: 'token') ?? '';

    print('This is Trade Page');

    final response = await http.get(
      Uri.parse('$baseUrl/trades'),
      headers: {
        'Authorization': 'Bearer $token',
        //"x-api-key": "b45c0c41a783490093921b95366b933e",
      },
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['trade'];
      return data.map((json) => TradeModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch trades');
    }
  }
}
