import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/drawers/home_drawer.dart';

import '../../../theme/palette.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }


  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider)!;
    ThemeData theme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: () => displayDrawer(context),
            icon: CircleAvatar(
              backgroundImage: NetworkImage(user.displayPic),
              radius: 35,
            ),
          );
        }),
        title: SvgPicture.asset(
          'assets/twitter-logo.svg',
          colorFilter: const ColorFilter.mode(
            Palette.blueColor,
            BlendMode.srcIn,
          ),
          fit: BoxFit.scaleDown,
          width: 35,
        ),
        centerTitle: true,
      ),
      body: Constants.tabScreens[_page],
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: theme.colorScheme.background,
        activeColor: theme.iconTheme.color,
        onTap: onPageChanged,
        currentIndex: _page,
        items: [
          BottomNavigationBarItem(
            icon:  Icon((_page == 0)?Icons.home : Icons.home_outlined),
          ),
          BottomNavigationBarItem(
            icon:  Icon((_page == 1)?Icons.search : Icons.search_outlined),
          ),
          BottomNavigationBarItem(
            icon:  Icon((_page == 2)?Icons.notifications : Icons.notifications_outlined),
          ),
          BottomNavigationBarItem(
            icon:  Icon((_page == 0)?Icons.mail : Icons.mail_outlined),
          ),
        ],
      ),
      drawer: const HomeDrawer(),
    );
  }
}
