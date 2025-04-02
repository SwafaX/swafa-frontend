abstract class TradeEvent {}

class FetchTradesEvent extends TradeEvent {}

class AcceptTradeEvent extends TradeEvent {
  final String tradeId;
  AcceptTradeEvent(this.tradeId);
}

class DeclineTradeEvent extends TradeEvent {
  final String tradeId;
  DeclineTradeEvent(this.tradeId);
}
