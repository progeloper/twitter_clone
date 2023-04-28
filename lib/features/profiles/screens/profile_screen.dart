import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/core/common/widgets/rounded_filled_button.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/profiles/controller/profile_controller.dart';
import 'package:twitter_clone/theme/palette.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  ConsumerState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final theme = ref.watch(themeProvider);
    return Scaffold(
      body: ref.watch(getProfileByIdProvider(widget.uid)).when(
            data: (profile) {
              return NestedScrollView(
                headerSliverBuilder: (context, isInnerBoxScrolled) {
                  return [
                    SliverAppBar(
                      expandedHeight: 150,
                      snap: true,
                      floating: true,
                      flexibleSpace: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned.fill(
                            child: Image.network(profile.banner),
                          ),
                          Positioned(
                            bottom: -20,
                            left: 20,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(profile.displayPic),
                              backgroundColor: Palette.lightGreyColor,
                              radius: 35,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const SizedBox(
                              height: 10,
                            ),
                            (widget.uid != user!.uid)
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.mail_outline)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons
                                                .notification_add_outlined)),
                                        (profile.following.contains(user!.uid))
                                            ? RoundedFilledButton(
                                                function: () {},
                                                label: 'Following',
                                                color: theme
                                                    .colorScheme.background,
                                              )
                                            : RoundedFilledButton(
                                                function: () {},
                                                label: 'Follow',
                                                color: theme
                                                    .colorScheme.background,
                                              ),
                                      ],
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: SizedBox(
                                      width: 120,
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 25),
                                        ),
                                        child: Text(
                                          'Edit Profile',
                                          style:
                                              theme.primaryTextTheme.bodyMedium,
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              profile.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              '@${profile.username}',
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(profile.bio),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 120.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.location_pin,
                                        color: Palette.darkGreyColor,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        profile.location,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Palette.darkGreyColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.link_outlined,
                                          color: Palette.darkGreyColor,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Flexible(
                                          child: GestureDetector(
                                            onTap: () =>
                                                launchUrlString(profile.url),
                                            child: Text(
                                              profile.url,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Palette.blueColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.celebration_outlined,
                                      color: Palette.darkGreyColor,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      profile.dob,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: Palette.darkGreyColor),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: Palette.darkGreyColor,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                        child: Text(
                                          profile.joined,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Palette.darkGreyColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      (profile.following.length - 1).toString(),
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                    const Text(
                                      ' Following',
                                      style: TextStyle(
                                          color: Palette.darkGreyColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      (profile.followers.length - 1).toString(),
                                      style: theme.textTheme.headlineMedium,
                                    ),
                                    const Text(
                                      ' Followers',
                                      style: TextStyle(
                                          color: Palette.darkGreyColor),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: TabBar(
                      indicatorColor: Palette.blueColor,
                      labelColor: theme.textTheme.titleMedium!.color,
                      tabs: const [
                        Tab(text: 'Tweets'),
                        Tab(text: 'Tweets & replies'),
                        Tab(text: 'Media'),
                        Tab(text: 'Likes'),
                      ],
                    ),
                    body: TabBarView(
                      children: [

                      ],
                    ),
                  ),
                ),
              );
            },
            error: (error, stackTrace) => Center(
              child: ErrorText(error: error.toString()),
            ),
            loading: () => const Center(
              child: Loader(),
            ),
          ),
    );
  }
}