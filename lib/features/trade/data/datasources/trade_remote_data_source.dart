import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swafa_app_frontend/features/trade/data/models/trade_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TradesRemoteDataSource {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  TradesRemoteDataSource({required this.baseUrl});

  // Helper function to fetch item image
  Future<String> _fetchItemImage(String itemId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/items/$itemId'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Fetch item: $itemId');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['item'];
        return data['image_url'];
      } else {
        throw Exception(
            'Failed to fetch item image for $itemId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching item $itemId: $e');
      rethrow;
    }
  }

  Future<List<TradeModel>> fetchSentTrades() async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    List<TradeModel> trades = [];

    print('Fetching Sent Trades');

    try {
      final sentResponse = await http.get(
        Uri.parse('$baseUrl/swap/sent'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Sent response status: ${sentResponse.statusCode}');
      print('Sent swaps: ${sentResponse.body}');

      if (sentResponse.statusCode == 200) {
        List sentData = jsonDecode(sentResponse.body)['data'];
        for (var swap in sentData) {
          try {
            String tradeImage =
                await _fetchItemImage(swap['request_item_id'], token);
            String myImage =
                await _fetchItemImage(swap['request_item_id'], token);
            String avatar = 'https://picsum.photos/id/237/200/300';

            trades.add(TradeModel(
              id: swap['ID'],
              tradeImage: tradeImage,
              myImage: myImage,
              avatar: avatar,
              message: swap['message'],
            ));
            print('Added sent trade: ${swap['ID']}');
          } catch (e) {
            print('Error processing sent swap ${swap['ID']}: $e');
          }
        }
      }
    } catch (e) {
      print('Error fetching sent swaps: $e');
    }

    print('Total sent trades fetched: ${trades.length}');
    return trades;
  }

  Future<List<TradeModel>> fetchReceivedTrades() async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    List<TradeModel> trades = [];

    print('Fetching Received Trades');

    try {
      final receivedResponse = await http.get(
        Uri.parse('$baseUrl/swap/received'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Received response status: ${receivedResponse.statusCode}');
      print('Received swaps: ${receivedResponse.body}');

      if (receivedResponse.statusCode == 200) {
        List receivedData = jsonDecode(receivedResponse.body)['data'];
        for (var swap in receivedData) {
          try {
            String tradeImage =
                await _fetchItemImage(swap['request_item_id'], token);
            String myImage =
                await _fetchItemImage(swap['request_item_id'], token);
            String avatar = 'https://picsum.photos/id/237/200/300';

            trades.add(TradeModel(
              id: swap['ID'],
              tradeImage: tradeImage,
              myImage: myImage,
              avatar: avatar,
              message: swap['message'],
            ));
            print('Added received trade: ${swap['ID']}');
          } catch (e) {
            print('Error processing received swap ${swap['ID']}: $e');
          }
        }
      }
    } catch (e) {
      print('Error fetching received swaps: $e');
    }

    print('Total received trades fetched: ${trades.length}');
    return trades;
  }

  Future<void> acceptTrade(String tradeId) async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    print('Accepting trade: $tradeId');
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/swap/$tradeId/accept'),
        headers: {
          'Authorization': 'Bearer $token'
        }, // No Content-Type since no body
      );

      print('Accept response status: ${response.statusCode}');
      print('Accept response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to accept trade $tradeId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error accepting trade $tradeId: $e');
      rethrow;
    }
  }

  Future<void> declineTrade(String tradeId) async {
    String token = await _storage.read(key: 'accessToken') ?? '';
    print('Declining trade: $tradeId');
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/swap/$tradeId/reject'),
        headers: {
          'Authorization': 'Bearer $token'
        }, // No Content-Type since no body
      );

      print('Decline response status: ${response.statusCode}');
      print('Decline response body: ${response.body}');

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to decline trade $tradeId: ${response.statusCode}');
      }
    } catch (e) {
      print('Error declining trade $tradeId: $e');
      rethrow;
    }
  }
}
