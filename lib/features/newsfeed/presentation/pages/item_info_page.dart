// import 'package:flutter/material.dart';

// class ItemInfoPage extends StatelessWidget {
//   ItemInfoPage({super.key, required this.image});
//   final String image;

//   final List<String> images = [
//     'assets/images/card1.png',
//     'assets/images/card2.png',
//     'assets/images/card3.png',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 24),
//           child: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: ColorConstants.primaryColor,
//             ),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         elevation: 0,
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(left: 8),
//             child: IconButton(
//               icon: Icon(
//                 Icons.more_vert,
//                 color: ColorConstants.primaryColor,
//               ),
//               onPressed: () {},
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 2,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(image),
//                       fit: BoxFit.cover,
//                       alignment: Alignment.topCenter,
//                       scale: 1.1,
//                     ),
//                   ),
//                 ),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20, top: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Text('Malena Veronica, 23',
//                               style: TextStyle(
//                                   fontSize: 24,
//                                   fontWeight: FontWeight.w500,
//                                   color: ColorConstants.secondary)),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Text('Fashion Designer at Victoria Secret',
//                           style: TextStyle(
//                               color: ColorConstants.secondary, fontSize: 16)),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Text('69m away',
//                           style: TextStyle(
//                               color: ColorConstants.secondary, fontSize: 16)),
//                       const SizedBox(
//                         height: 32,
//                       ),
//                       Text('DESCRIPTION',
//                           style: TextStyle(
//                               color: ColorConstants.secondary,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500)),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       Text(
//                         'Hey guys, This is Malena. I’m here to find someone for hookup. I’m not interested in something serious. I would love to hear your adventurous story.',
//                         style: TextStyle(
//                           color: ColorConstants.secondary,
//                           fontSize: 16,
//                           height: 1.5,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _chip(
//       {required Color background,
//       required Color color,
//       required String title}) {
//     return Chip(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       label: Text(title, style: TextStyle(color: color)),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(32),
//       ),
//       backgroundColor: background,
//     );
//   }
// }
