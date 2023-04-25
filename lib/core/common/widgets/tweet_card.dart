import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweets/screens/create_comment_screen.dart';
import 'package:twitter_clone/features/tweets/screens/tweet_screen.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../features/auth/controller/auth_controller.dart';
import '../../../models/user.dart';

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
          CircleAvatar(
            backgroundImage: NetworkImage(tweet.profilePic),
            radius: 30,
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
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${tweet.name}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
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
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TweetScreen(tweet: tweet)));
                        },
                        child: Text(
                          tweet.tweet,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      if (tweet.imageLink != null)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TweetScreen(tweet: tweet)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Image.network(tweet.imageLink!),
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
                                          CreateCommentScreen(tweet: tweet)));
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
                                onPressed: ()=>retweetTweet(context, ref, user.uid),
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
                                icon: (tweet.likes.contains(user!.uid))
                                    ? FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        color: Palette.redColor,
                                      )
                                    : FaIcon(
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
                            icon: FaIcon(
                              FontAwesomeIcons.shareNodes,
                              color: Palette.darkGreyColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
