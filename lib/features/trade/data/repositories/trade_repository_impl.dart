import 'package:swafa_app_frontend/features/trade/data/datasources/trade_remote_data_source.dart';
import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';
import 'package:swafa_app_frontend/features/trade/domain/repositories/trade_repository.dart';

class TradeRepositoryImpl implements TradeRepository{
  final TradesRemoteDataSource tradesRemoteDataSource;

  TradeRepositoryImpl({required this.tradesRemoteDataSource});

  @override
  Future<List<TradeEntity>> fetchTrade() async {
    return await tradesRemoteDataSource.fetchTrades();
  }
}