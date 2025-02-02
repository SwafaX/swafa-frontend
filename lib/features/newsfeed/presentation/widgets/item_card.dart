import 'package:flutter/material.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/pages/item_info_page.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.image});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder:  (context) => ItemInfoPage(image: image))
              // );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: AssetImage(image.toString()),
                  fit: BoxFit.cover,
                ),
                )
              ),
          ),
          // Positioned(
          //   bottom: 30,
          //   right: 0,
          //   child: Container(
          //     height: 104,
          //     width: MediaQuery.of(context).size.width / 1.2,
          //     padding: const EdgeInsets.all(16),
          //     decoration: BoxDecoration(
          //       color: Colors.white.withOpacity(0.8),
          //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomLeft: Radius.circular(16)),
          //     ),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('Malena Veronica, 23', style: TextStyle(color: ColorConstants.secondary, fontSize: 24, fontWeight: FontWeight.w500)),
          //         const SizedBox(height: 12,),
          //         Text('Fashion Designer at Victoria Secret', style: TextStyle(color: ColorConstants.secondary, fontSize: 16)),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}