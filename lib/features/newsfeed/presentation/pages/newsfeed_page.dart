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

  @override
  void initState() {
    super.initState();
    _fetchNewsFeed();
  }

  @override
  void dispose() {
    _swipeController.dispose();
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

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build

    return RefreshIndicator(
      backgroundColor: DefaultColors.secondary100,
      color: DefaultColors.primary500,
      onRefresh: _onRefresh,
      child: BlocListener<NewsfeedBloc, NewsfeedState>(
        listener: (context, state) {
          if (state is NewsfeedLoadedState || state is NewsfeedErrorState) {
            _refreshCompleter?.complete();
          }
        },
        child: BlocBuilder<NewsfeedBloc, NewsfeedState>(
          builder: (context, state) {
            if (state is NewsfeedLoadingState) {
              return const ShimmerLoadingCard(
                height: 600,
              );
            } else if (state is NewsfeedLoadedState) {
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
                            padding: const EdgeInsets.only(bottom: 20, top: 80),
                            child: ItemCard(
                              title: state.items[index].title,
                              description: state.items[index].description,
                              image: state.items[index].imageUrl,
                            ),
                          );
                        },
                        swipeOptions: const SwipeOptions.symmetric(
                          horizontal: true,
                          vertical: false,
                        ),
                        invertAngleOnBottomDrag: false,
                        cardCount: state.items.length,
                        controller: _swipeController,
                        onCardPositionChanged: (position) {},
                        onSwipeEnd: (previousIndex, targetIndex, activity) {
                          if (activity is Swipe) {
                            if (activity.direction == AxisDirection.right) {
                              print('Swipe direction: ${activity.direction}');
                            } else {
                              print('Swipe direction: ${activity.direction}');
                            }
                          }
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            _swipeController.swipeLeft();
                          },
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
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Color(0xFF040509),
                              size: 32,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _swipeController.swipeRight();
                          },
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
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.favorite,
                              color: Color(0xFFF74440),
                              size: 32,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            } else if (state is NewsfeedErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            return const Center(
              child: Text('No newsfeed items found'),
            );
          },
        ),
      ),
    );
  }
}
