import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';

abstract class TradeRepository {
  Future<List<TradeEntity>> fetchTrade();
}