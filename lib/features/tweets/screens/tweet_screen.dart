import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/core/common/widgets/comment_card.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';
import 'package:twitter_clone/features/tweets/screens/create_comment_screen.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../models/tweet.dart';

class TweetScreen extends ConsumerStatefulWidget {
  final String tweetId;
  const TweetScreen({
    Key? key,
    required this.tweetId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _TweetScreenState();
}

class _TweetScreenState extends ConsumerState<TweetScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Image.network(
              tweet.imageLink[1],
              fit: BoxFit.cover,
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
                fit: BoxFit.cover,
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
                      fit: BoxFit.cover,
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
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  tweet.imageLink[1],
                  fit: BoxFit.cover,
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
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  tweet.imageLink[3],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  void goBack(BuildContext context) {
    Routemaster.of(context).pop();
  }

  void likeTweet(BuildContext context, WidgetRef ref, String userId, Tweet tweet) {
    ref
        .read(tweetControllerProvider.notifier)
        .likeTweet(tweet, userId, context);
    setState(() {});
  }

  void retweetTweet(BuildContext context, WidgetRef ref, String userId, Tweet tweet) {
    ref
        .read(tweetControllerProvider.notifier)
        .retweetTweet(tweet, userId, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    final theme = ref.watch(themeProvider);
    final tweet = ref.watch(tweetFromIdProvider(widget.tweetId)).value;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        leading: IconButton(
            onPressed: () => goBack(context),
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: theme.colorScheme.onPrimary,
            )),
        title: const Text(
          'Thread',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.background,
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: theme.colorScheme.secondary, width: 0.5),
              bottom:
                  BorderSide(color: theme.colorScheme.secondary, width: 0.5),
            ),
          ),
          child: TextFormField(
            controller: _controller,
            onTap: () {
              Routemaster.of(context).push('/create-comment-screen/${tweet!.tweetId}');
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: false,
              hintText: 'Tweet your reply',
              hintStyle: TextStyle(
                color: Palette.darkGreyColor,
              ),
            ),
          ),
        ),
      ),
      body: ref.watch(tweetFromIdProvider(widget.tweetId)).when(
          data: (tweet) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Palette.darkGreyColor, width: 0.5),
                      bottom:
                          BorderSide(color: Palette.darkGreyColor, width: 0.5),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
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
                                SizedBox(
                                  height: 30,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            tweet.tweet,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (tweet.imageLink.isNotEmpty)
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: getImages(tweet),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: theme.colorScheme.secondary,
                        thickness: 1.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          tweet.postedAt,
                          style: const TextStyle(
                            color: Palette.darkGreyColor,
                          ),
                        ),
                      ),
                      Divider(
                        color: theme.colorScheme.secondary,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              tweet.commentCount.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Comments',
                              style: TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              tweet.retweets.length.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Retweets',
                              style: TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              tweet.likes.length.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Likes',
                              style: TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const FaIcon(
                              FontAwesomeIcons.comment,
                              color: Palette.darkGreyColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                retweetTweet(context, ref, user.uid, tweet),
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
                          IconButton(
                            onPressed: () => likeTweet(context, ref, user.uid, tweet),
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
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.share_outlined,
                              color: Palette.darkGreyColor,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: theme.colorScheme.secondary,
                        thickness: 1.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 800,
                        child: ref
                            .watch(fetchTweetCommentsProvider(tweet.tweetId))
                            .when(
                              data: (comments) {
                                return ListView.builder(
                                    itemCount: comments.length,
                                    itemBuilder: (context, index) {
                                      final comment = comments[index];
                                      return CommentCard(comment: comment);
                                    });
                              },
                              error: (error, stackTrace) {
                                print(stackTrace.toString());
                                return Center(
                                  child: ErrorText(error: error.toString()),
                                );
                              },
                              loading: () => const Center(child: Loader()),
                            ),
                      ),
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
              )),
    );
  }
}
