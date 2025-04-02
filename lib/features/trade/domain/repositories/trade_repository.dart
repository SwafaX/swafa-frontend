import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';

abstract class TradeRepository {
  Future<List<TradeEntity>> fetchSentTrade();
  Future<List<TradeEntity>> fetchReceivedTrade();
  Future<void> acceptTrade(String itemId);
  Future<void> declineTrade(String itemId);
}
