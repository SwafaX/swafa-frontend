import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';

class TradeModel extends TradeEntity {
  TradeModel({
    required super.id,
    required super.tradeImage,
    required super.myImage,
    required super.avatar,
    required super.message,
  });

  factory TradeModel.fromJson(Map<String, dynamic> json) {
    return TradeModel(
      id: json['id'],
      tradeImage: json['tradeImage'],
      myImage: json['myImage'],
      avatar: json['avatar'],
      message: json['message'],
    );
  }
}
