import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swafa_app_frontend/core/theme.dart';
import 'package:swafa_app_frontend/features/conversation/presentation/pages/conversations_page.dart';
import 'package:swafa_app_frontend/features/newsfeed/presentation/pages/newsfeed_page.dart';
import 'package:swafa_app_frontend/features/trade/presentation/pages/trades_page.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final PageController _pageController = PageController();
  int _selectedPageIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _selectPage(int index) {
    _pageController.jumpToPage(index);
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var activePageTitle = ['', 'My Trades', 'Message', 'Profile'][_selectedPageIndex];

    return Scaffold(
      appBar: activePageTitle != '' ? AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
        backgroundColor: Colors.white,
        titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
        toolbarHeight: 130,
      ): null,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        children: const [
          NewsFeedPage(),
          TradesPage(),
          ConversationsPage(),
          Center(child: Text('Nothing to show')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: DefaultColors.primary50,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        enableFeedback: false,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/newsfeed.svg',
            ),
            label: '',
            activeIcon: SvgPicture.asset('assets/icons/newsfeed_selected.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/favorite.svg'),
            label: '',
            activeIcon: SvgPicture.asset('assets/icons/favorite_selected.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/chat.svg'),
            label: '',
            activeIcon: SvgPicture.asset('assets/icons/chat_selected.svg'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/icons/user.svg'),
            label: '',
            activeIcon: SvgPicture.asset('assets/icons/user_selected.svg'),
          ),
        ],
      ),
    );
  }
}
