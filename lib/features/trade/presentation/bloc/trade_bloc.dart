import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/trade/domain/usecases/fetch_trades_use_case.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_event.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_state.dart';

class TradeSentBloc extends Bloc<TradeEvent, TradeState> {
  final FetchTradesUseCase fetchTradesUseCase;

  TradeSentBloc({required this.fetchTradesUseCase})
      : super(TradesInitialState()) {
    on<FetchTradesEvent>(_onFetchSentTrades);
  }

  Future<void> _onFetchSentTrades(
      FetchTradesEvent event, Emitter<TradeState> emit) async {
    emit(TradesLoadingState());
    try {
      final trades = await fetchTradesUseCase.callSent();
      emit(TradesLoadedState(trades: trades));
    } catch (e) {
      emit(TradesError(message: 'Failed to load trades'));
    }
  }
}

class TradeReceivedBloc extends Bloc<TradeEvent, TradeState> {
  final FetchTradesUseCase fetchTradesUseCase;
  final AcceptTradeUseCase acceptTradeUseCase;
  final DeclineTradeUseCase declineTradeUseCase;

  TradeReceivedBloc(
      {required this.fetchTradesUseCase,
      required this.acceptTradeUseCase,
      required this.declineTradeUseCase})
      : super(TradesInitialState()) {
    on<FetchTradesEvent>(_onFetchReceivedTrades);
    on<AcceptTradeEvent>(_onAcceptTrade);
    on<DeclineTradeEvent>(_onDeclineTrade);
  }

  Future<void> _onFetchReceivedTrades(
      FetchTradesEvent event, Emitter<TradeState> emit) async {
    emit(TradesLoadingState());
    try {
      final trades = await fetchTradesUseCase.callReceived();
      emit(TradesLoadedState(trades: trades));
    } catch (e) {
      emit(TradesError(message: 'Failed to load trades'));
    }
  }

  Future<void> _onAcceptTrade(
      AcceptTradeEvent event, Emitter<TradeState> emit) async {
    try {
      await acceptTradeUseCase(event.tradeId);
      // Refresh the trades list after accepting
      final trades = await fetchTradesUseCase.callReceived();
      emit(TradesLoadedState(trades: trades));
    } catch (e) {
      emit(TradesError(message: 'Failed to accept trade'));
    }
  }

  Future<void> _onDeclineTrade(
      DeclineTradeEvent event, Emitter<TradeState> emit) async {
    try {
      await declineTradeUseCase(event.tradeId);
      // Refresh the trades list after declining
      final trades = await fetchTradesUseCase.callReceived();
      emit(TradesLoadedState(trades: trades));
    } catch (e) {
      emit(TradesError(message: 'Failed to decline trade'));
    }
  }
}
