import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/home/screens/settings_screen.dart';
import 'package:twitter_clone/features/profiles/screens/profile_screen.dart';
import 'package:twitter_clone/theme/palette.dart';

class HomeDrawer extends ConsumerWidget {
  const HomeDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider);
    final theme = ref.watch(themeProvider);

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      elevation: 15,
      child: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: (){
                  Routemaster.of(context).push('/profile-screen/${user.uid}');
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user!.displayPic),
                ),
              ),
              Constants.spaceBox10,
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '@${user.username}',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              Constants.spaceBox20,
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${user.following.length-1} ',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Following',
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.darkGreyColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${user.followers.length-1} ',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    'Followers',
                    style: TextStyle(
                      fontSize: 16,
                      color: Palette.darkGreyColor,
                    ),
                  ),
                ],
              ),
              Constants.spaceBox30,
              Divider(
                color: theme.colorScheme.onPrimary,
              ),
              ListTile(
                onTap: () {
                  Routemaster.of(context).push('/profile-screen/${user.uid}');
                },
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const Icon(
                  Icons.person_outline,
                  size: 25,
                ),
                title: const Text(
                  'Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.only(left: 0),
                leading: SvgPicture.asset(
                  'assets/twitter-verified-badge.svg',
                  colorFilter: const ColorFilter.mode(
                    Palette.blueColor,
                    BlendMode.srcIn,
                  ),
                  fit: BoxFit.contain,
                  width: 25,
                ),
                title: const Text(
                  'Twitter Blue',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const Icon(
                  Icons.chat_bubble_outline,
                  size: 25,
                ),
                title: const Text(
                  'Topics',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const Icon(
                  Icons.bookmark_border,
                  size: 25,
                ),
                title: const Text(
                  'Bookmarks',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const Icon(
                  Icons.list_alt_outlined,
                  size: 25,
                ),
                title: const Text(
                  'Lists',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                contentPadding: const EdgeInsets.only(left: 0),
                leading: const Icon(
                  Icons.lock_outline,
                  size: 25,
                ),
                title: const Text(
                  'Protect Tweets',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              Constants.spaceBox30,
              Divider(
                color: theme.colorScheme.onPrimary,
              ),
              ListTile(
                onTap: () {
                  Routemaster.of(context).push('/settings-screen');
                },
                contentPadding: const EdgeInsets.only(left: 0),
                title: const Text(
                  'Settings & Support',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 25,
                ),
              ),
              Expanded(child: Container()),
              IconButton(
                onPressed: () {
                  ref.read(themeProvider.notifier).toggleTheme();
                },
                icon: const Icon(
                  Icons.sunny,
                  size: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
