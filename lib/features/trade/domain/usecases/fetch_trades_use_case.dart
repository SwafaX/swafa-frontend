import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';
import 'package:swafa_app_frontend/features/trade/domain/repositories/trade_repository.dart';

class FetchTradesUseCase {
  final TradeRepository tradeRepository;

  FetchTradesUseCase({required this.tradeRepository});

  Future<List<TradeEntity>> call() async {
    return await tradeRepository.fetchTrade();
  }
}