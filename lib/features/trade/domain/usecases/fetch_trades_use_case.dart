import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';
import 'package:swafa_app_frontend/features/trade/domain/repositories/trade_repository.dart';

class FetchTradesUseCase {
  final TradeRepository tradeRepository;

  FetchTradesUseCase({required this.tradeRepository});

  Future<List<TradeEntity>> callSent() async {
    return await tradeRepository.fetchSentTrade();
  }

  Future<List<TradeEntity>> callReceived() async {
    return await tradeRepository.fetchReceivedTrade();
  }
}

class AcceptTradeUseCase {
  final TradeRepository repository;

  AcceptTradeUseCase({required this.repository});

  Future<void> call(String tradeId) async {
    return await repository.acceptTrade(tradeId);
  }
}

class DeclineTradeUseCase {
  final TradeRepository repository;

  DeclineTradeUseCase({required this.repository});

  Future<void> call(String tradeId) async {
    return await repository.declineTrade(tradeId);
  }
}
