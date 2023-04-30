import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/core/common/widgets/tweet_card.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../tweets/screens/create_tweet_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FeedScreenState();
}

void navigateToCreateTweetScreen(BuildContext context) {
  Routemaster.of(context).push('/create-tweet-screen');
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.blueColor,
        onPressed: () => navigateToCreateTweetScreen(context),
        child: const Icon(
          Icons.add,
        ),
      ),
      body: ref.watch(getUsersFollowingProvider(user!.uid)).when(
          data: (tweeters) {
            return ref.watch(fetchUserFeedProvider(tweeters)).when(
                data: (tweets) {
                  return ListView.builder(
                    itemCount: tweets.length,
                    itemBuilder: (context, index) {
                      final tweet = tweets[index];
                      print(tweet.name);
                      return TweetCard(tweet: tweet);
                    },
                  );
                },
                error: (error, stackTrace) {
                  print(stackTrace.toString());
                  return Center(child: ErrorText(error: error.toString()));
                },
                loading: () => const Center(child: Loader()));
          },
          error: (error, StackTrace) =>
              Center(child: ErrorText(error: error.toString())),
          loading: () => const Center(child: Loader())),
    );
  }
}
