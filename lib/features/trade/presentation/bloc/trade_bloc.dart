import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/trade/domain/usecases/fetch_trades_use_case.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_event.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_state.dart';

class TradeBloc extends Bloc<TradeEvent, TradeState> {
  final FetchTradesUseCase fetchTradesUseCase;

  TradeBloc({required this.fetchTradesUseCase}) : super(TradesInitialState()) {
    on<FetchTradesEvent>(_onFetchTrades);
  }

  Future<void> _onFetchTrades(FetchTradesEvent event, Emitter<TradeState> emit) async {
    emit(TradesLoadingState());
    try {
      final trades = await fetchTradesUseCase.call();
      emit(TradesLoadedState(trades: trades));
    } catch (e) {
      emit(TradesError(message: 'Failed to load trades'));
    }
  }
}