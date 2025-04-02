import 'dart:async';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_event.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_state.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/widgets/item_card.dart';
import 'package:swafa_app_frontend/shimmer/shimmer_loading_card.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage>
    with AutomaticKeepAliveClientMixin<NewsFeedPage> {
  @override
  bool get wantKeepAlive => true;

  final AppinioSwiperController _swipeController = AppinioSwiperController();
  Completer<void>? _refreshCompleter;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNewsFeed();
  }

  @override
  void dispose() {
    _swipeController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _fetchNewsFeed() {
    _refreshCompleter = Completer<void>();
    BlocProvider.of<NewsfeedBloc>(context).add(FetchItemsEvent());
  }

  Future<void> _onRefresh() async {
    _fetchNewsFeed();
    return _refreshCompleter!.future;
  }

  Widget _buildDefaultButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () => _swipeController.swipeLeft(),
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ],
            ),
            child: const Icon(Icons.close, color: Color(0xFF040509), size: 32),
          ),
        ),
        InkWell(
          onTap: () => _swipeController.swipeRight(),
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 242, 205, 205),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ],
            ),
            child:
                const Icon(Icons.favorite, color: Color(0xFFF74440), size: 32),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageBar(String itemId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          _swipeController.unswipe();
                          _messageController.clear();
                          BlocProvider.of<NewsfeedBloc>(context)
                              .add(CancelMessageEvent());
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<NewsfeedBloc>(context).add(
                            SendMessageEvent(
                              itemId: itemId,
                              message: _messageController.text,
                            ),
                          );
                          _messageController.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Send'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ).whenComplete(() {
          // Called when the bottom sheet is dismissed (e.g., tapping outside)
          _swipeController.unswipe(); // Bring back the card
          _messageController.clear(); // Clear the text field
          BlocProvider.of<NewsfeedBloc>(context)
              .add(CancelMessageEvent()); // Reset state
        });
      }
    });
    return _buildDefaultButtons();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      backgroundColor: DefaultColors.secondary100,
      color: DefaultColors.primary500,
      onRefresh: _onRefresh,
      child: BlocListener<NewsfeedBloc, NewsfeedState>(
        listener: (context, state) {
          if (state is NewsfeedLoadedState || state is NewsfeedErrorState) {
            _refreshCompleter?.complete();
          }
          if (state is MessageSentState) {
            _swipeController.swipeRight(); // Move to next card after success
          }
          if (state is NewsfeedErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: BlocBuilder<NewsfeedBloc, NewsfeedState>(
          builder: (context, state) {
            if (state is NewsfeedLoadingState) {
              return const ShimmerLoadingCard(height: 600);
            } else if (state is NewsfeedLoadedState ||
                state is MessageInputState ||
                state is MessageSendingState ||
                state is MessageSentState) {
              final items = (state is NewsfeedLoadedState)
                  ? state.items
                  : (state is MessageInputState)
                      ? state.items
                      : (state is MessageSendingState)
                          ? state.items
                          : (state as MessageSentState).items;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                child: Column(
                  children: [
                    SizedBox(
                      height: 700,
                      child: AppinioSwiper(
                        cardBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 80),
                            child: ItemCard(
                              title: items[index].title,
                              description: items[index].description,
                              image: items[index].imageUrl,
                            ),
                          );
                        },
                        swipeOptions: const SwipeOptions.symmetric(
                            horizontal: true, vertical: false),
                        invertAngleOnBottomDrag: false,
                        cardCount: items.length,
                        controller: _swipeController,
                        onSwipeEnd: (previousIndex, targetIndex, activity) {
                          if (activity is Swipe &&
                              activity.direction == AxisDirection.right) {
                            print('Item Id Sent:' + items[previousIndex].id);
                            BlocProvider.of<NewsfeedBloc>(context).add(
                                SwipeRightEvent(
                                    itemId: items[previousIndex].id));
                          }
                        },
                      ),
                    ),
                    if (state is MessageInputState ||
                        state is MessageSendingState)
                      _buildMessageBar(state is MessageInputState
                          ? state.currentItemId
                          : (state as MessageSendingState).items.first.id)
                    else
                      _buildDefaultButtons(),
                  ],
                ),
              );
            } else if (state is NewsfeedErrorState) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('No newsfeed items found'));
          },
        ),
      ),
    );
  }
}
