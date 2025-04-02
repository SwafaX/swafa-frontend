import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/trade/domain/entities/trade_entity.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_event.dart';

class ReceivedTradesListView extends StatelessWidget {
  final List<TradeEntity> trades;

  const ReceivedTradesListView({super.key, required this.trades});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: trades.length,
      itemBuilder: (context, index) {
        final trade = trades[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch to full width
            children: [
              Card(
                color: const Color(0xFFF4F4F4),
                elevation: 0,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 17, horizontal: 27),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                trade.tradeImage,
                                width: 90,
                                height: 85,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Icon(Icons.swap_horiz, size: 32),
                          Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1.0, color: Colors.black),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                trade.myImage,
                                width: 90,
                                height: 85,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 29,
                            height: 29,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(trade.avatar),
                            ),
                          ),
                          SizedBox(width: 11),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, top: 5, bottom: 5, right: 10),
                                child: Text(
                                  trade.message,
                                  style: const TextStyle(fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10), // Space between card and buttons
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Spread buttons to both sides
                children: [
                  ElevatedButton(
                    onPressed: () {
                      print('Accept trade: ${trade.id}');
                      BlocProvider.of<TradeReceivedBloc>(context)
                          .add(AcceptTradeEvent(trade.id));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB2DFDB), // Pastel green
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12), // Bigger padding
                      minimumSize:
                          const Size(120, 40), // Minimum width and height
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black), // Larger text
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print('Decline trade: ${trade.id}');
                      BlocProvider.of<TradeReceivedBloc>(context)
                          .add(DeclineTradeEvent(trade.id));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB2B2), // Pastel red
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12), // Bigger padding
                      minimumSize:
                          const Size(120, 40), // Minimum width and height
                    ),
                    child: const Text(
                      'Decline',
                      style: TextStyle(
                          fontSize: 16, color: Colors.black), // Larger text
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
