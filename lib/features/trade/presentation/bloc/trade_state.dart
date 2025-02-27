import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';

abstract class TradeState {}

class TradesInitialState extends TradeState {}

class TradesLoadedState extends TradeState {
  final List<TradeEntity> trades;

  TradesLoadedState({required this.trades});
}

class TradesLoadingState extends TradeState {}

class TradesError extends TradeState {
  final String message;

  TradesError({required this.message});
}