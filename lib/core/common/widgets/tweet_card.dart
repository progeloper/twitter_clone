import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/features/profiles/screens/profile_screen.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweets/screens/create_comment_screen.dart';
import 'package:twitter_clone/features/tweets/screens/tweet_screen.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../features/auth/controller/auth_controller.dart';

class TweetCard extends ConsumerStatefulWidget {
  final Tweet tweet;
  const TweetCard({
    Key? key,
    required this.tweet,
  }) : super(key: key);
  @override
  ConsumerState createState() => _TweetCardState();
}

class _TweetCardState extends ConsumerState<TweetCard> {
  void likeTweet(BuildContext context, WidgetRef ref, String userId) async {
    ref
        .read(tweetControllerProvider.notifier)
        .likeTweet(widget.tweet, userId, context);
    setState(() {});
  }

  void retweetTweet(BuildContext context, WidgetRef ref, String userId) async {
    ref
        .read(tweetControllerProvider.notifier)
        .retweetTweet(widget.tweet, userId, context);
    setState(() {});
  }
  Widget getImages(Tweet tweet){
    if(tweet.imageLink.length == 1) {
      return Image.network(tweet.imageLink[0]);
    } else if(tweet.imageLink.length == 2) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image.network(
              tweet.imageLink[0],
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Image.network(
              tweet.imageLink[1],
              fit: BoxFit.fill,
            ),
          ),
        ],
      );
    }
    else if(tweet.imageLink.length == 3) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Image.network(
                tweet.imageLink[0],
                fit: BoxFit.fill,
              )),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Image.network(
                      tweet.imageLink[1],
                      fit: BoxFit.fill,
                    )),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                    child: Image.network(
                        tweet.imageLink[2])),
              ],
            ),
          ),
        ],
      );
    }
        else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Expanded(
                child: Image.network(
                  tweet.imageLink[0],
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  tweet.imageLink[1],
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 2,
          ),
          Column(
            children: [
              Expanded(
                child: Image.network(
                  tweet.imageLink[2],
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  tweet.imageLink[3],
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ],
      );
  }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final user = ref.read(userProvider);
    final tweet = widget.tweet;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
          border: Border(
        top: BorderSide(color: Palette.darkGreyColor, width: 0.5),
        bottom: BorderSide(color: Palette.darkGreyColor, width: 0.5),
      )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ProfileScreen(uid: tweet.uid)));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(tweet.profilePic),
              radius: 30,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: tweet.name,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onPrimary,
                          ),
                          children: [
                            TextSpan(
                              text: ' @${tweet.username}',
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Palette.darkGreyColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TweetScreen(tweetId: tweet.tweetId)));
                      },
                      child: Text(
                        tweet.tweet,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (tweet.imageLink.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TweetScreen(tweetId: tweet.tweetId)));
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: getImages(tweet),

                        ),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        CreateCommentScreen(tweetId: tweet.tweetId)));
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.comment,
                                color: Palette.darkGreyColor,
                              ),
                            ),
                            Text(
                              tweet.commentCount.toString(),
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  retweetTweet(context, ref, user.uid),
                              icon: (tweet.retweets.contains(user!.uid))
                                  ? const FaIcon(
                                      FontAwesomeIcons.retweet,
                                      color: Palette.greenColor,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.retweet,
                                      color: Palette.darkGreyColor,
                                    ),
                            ),
                            Text(
                              tweet.retweets.length.toString(),
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  likeTweet(context, ref, user.uid),
                              icon: (tweet.likes.contains(user.uid))
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: Palette.redColor,
                                    )
                                  : const FaIcon(
                                      FontAwesomeIcons.heart,
                                      color: Palette.darkGreyColor,
                                    ),
                            ),
                            Text(
                              tweet.likes.length.toString(),
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share_outlined,
                            color: Palette.darkGreyColor,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

