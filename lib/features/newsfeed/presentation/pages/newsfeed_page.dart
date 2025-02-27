import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_bloc.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_event.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/bloc/newsfeed_state.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/widgets/item_card.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> with AutomaticKeepAliveClientMixin<NewsFeedPage> {
  @override
  bool get wantKeepAlive => true;

  final AppinioSwiperController _swipeController = AppinioSwiperController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsfeedBloc>(context).add(FetchItemsEvent());
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build
    
    return BlocBuilder<NewsfeedBloc, NewsfeedState>(
      builder: (context, state) {
        if (state is NewsfeedLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsfeedLoadedState) {
          return Stack(
            children: [
              AppinioSwiper(
                cardBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 150, top: 80),
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
              ),
              Positioned(
                bottom: 50,
                right: 0,
                left: 0,
                child: Row(
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
              ),
            ],
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
    );
  }
}
