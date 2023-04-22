import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../features/auth/controller/auth_controller.dart';
import '../../../models/user.dart';

class TweetCard extends ConsumerWidget {
  final Tweet tweet;
  const TweetCard({
    Key? key,
    required this.tweet,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: Palette.darkGreyColor, width: 0.5),
          bottom: BorderSide(color: Palette.darkGreyColor, width: 0.5),
        )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(tweet.profilePic),
            radius: 30,
          ),
        ],
      ),
    );
  }
}