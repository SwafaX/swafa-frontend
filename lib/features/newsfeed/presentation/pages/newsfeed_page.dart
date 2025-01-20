import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/widgets/item_card.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage> {
  final AppinioSwiperController _swipeController = AppinioSwiperController();

  List<ItemCard> profile = [];

  List<String> images = [
    'assets/images/card1.png',
    'assets/images/card2.png',
    'assets/images/card3.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadCards();
  }

  @override
  void dispose() {
    _swipeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          AppinioSwiper(
            cardBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 150, top: 16),
                child: profile[index],
              );
            },
            swipeOptions: const SwipeOptions.symmetric(horizontal: true, vertical: false),
            invertAngleOnBottomDrag: false,
            cardCount: profile.length,
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
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
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
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  void _loadCards() {
    for (String image in images) {
      profile.add(ItemCard(image: image));
    }
  }
}
