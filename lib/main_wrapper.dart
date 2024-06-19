import 'package:animate_do/animate_do.dart';
import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:e_commerce_app/screens/cart.dart';
import 'package:e_commerce_app/screens/home.dart';
import 'package:e_commerce_app/screens/search.dart';
import 'package:e_commerce_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final int _index = 0;
  bool isSearchActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: isSearchActive
            ? FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            : FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        actions: [
          IconButton(
            icon: isSearchActive
                ? const Icon(
                    LineIcons.searchMinus,
                    color: Colors.black,
                    size: 30,
                  )
                : const Icon(
                    LineIcons.search,
                    color: Colors.black,
                    size: 30,
                  ),
            onPressed: () {
              setState(
                () {
                  isSearchActive = !isSearchActive;
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(
              LineIcons.shoppingBag,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Cart(),
                ),
              );
            },
          ),
        ],
      ),
      body: isSearchActive ? const Search() : const Home(),
      bottomNavigationBar: BottomBarBubble(
        color: primaryColor,
        selectedIndex: _index,
        items: [
          BottomBarItem(
            iconData: Icons.home,
          ),
          BottomBarItem(
            iconData: Icons.search,
          ),
          BottomBarItem(
            iconData: Icons.explore,
          ),
          BottomBarItem(
            iconData: Icons.settings,
          ),
          BottomBarItem(
            iconData: Icons.mail,
          ),
        ],
        onSelect: (index) {
          print('Selected index: $index');
        },
      ),
    );
  }
}
