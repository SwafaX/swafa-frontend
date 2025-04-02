import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_event.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_state.dart';
import 'package:swafa_app_frontend/features/trade/presentation/widgets/received_trades_list_view.dart';
import 'package:swafa_app_frontend/features/trade/presentation/widgets/sent_%20trades_list_view.dart';
import 'package:swafa_app_frontend/shimmer/shimmer_loading_card.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({super.key});

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage>
    with AutomaticKeepAliveClientMixin<TradesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TradeSentBloc>(context).add(FetchTradesEvent());
    BlocProvider.of<TradeReceivedBloc>(context).add(FetchTradesEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, top: 50),
        child: Column(
          children: [
            TabBar(
              physics: const ClampingScrollPhysics(),
              unselectedLabelColor: const Color(0xFF7F7F7F),
              labelColor: const Color(0xFF323232),
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color(0xFFD9D9D9),
              ),
              tabs: const [
                Tab(
                  height: 28,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Sent'),
                  ),
                ),
                Tab(
                  height: 28,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Received'),
                  ),
                )
              ],
              dividerHeight: 0,
              enableFeedback: false,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: BlocBuilder<TradeSentBloc, TradeState>(
                      builder: (context, state) {
                        if (state is TradesLoadingState) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: List.generate(
                                3,
                                (_) => const ShimmerLoadingCard(
                                      height: 170,
                                    )), // Show shimmer effect for 3 cards
                          );
                        } else if (state is TradesLoadedState) {
                          final trades = state.trades;
                          return SentTradesListView(trades: trades);
                        } else if (state is TradesError) {
                          return Center(
                            child: Text(state.message),
                          );
                        }
                        return const Center(
                          child: Text('No trades found'),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: BlocBuilder<TradeReceivedBloc, TradeState>(
                      builder: (context, state) {
                        if (state is TradesLoadingState) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: List.generate(
                                3,
                                (_) => const ShimmerLoadingCard(
                                      height: 170,
                                    )), // Show shimmer effect for 3 cards
                          );
                        } else if (state is TradesLoadedState) {
                          final trades = state.trades;
                          return ReceivedTradesListView(trades: trades);
                        } else if (state is TradesError) {
                          return Center(
                            child: Text(state.message),
                          );
                        }
                        return const Center(
                          child: Text('No trades found'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
