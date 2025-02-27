import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_bloc.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_event.dart';
import 'package:swafa_app_frontend/features/trade/presentation/bloc/trade_state.dart';
import 'package:swafa_app_frontend/features/trade/presentation/widgets/trades_list_view.dart';

class TradesPage extends StatefulWidget {
  const TradesPage({super.key});

  @override
  State<TradesPage> createState() => _TradesPageState();
}

class _TradesPageState extends State<TradesPage> with AutomaticKeepAliveClientMixin<TradesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TradeBloc>(context).add(FetchTradesEvent());
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
                      child: BlocBuilder<TradeBloc, TradeState>(
                        builder: (context, state) {
                          if (state is TradesLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is TradesLoadedState) {
                            final trades = state.trades;
                            return TradesListView(trades: trades);
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
                    const Center(child: Text("No trades received yet!")),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
