import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/core/common/widgets/tweet_card.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';

import '../../tweets/screens/create_tweet_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FeedScreenState();
}

void navigateToCreateTweetScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CreateTweetScreen()));
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCreateTweetScreen(context),
        child: const FaIcon(
          FontAwesomeIcons.paperPlane,
        ),
      ),
      body: ref
          .watch(fetchUserFeedProvider(user!.following as List<String>))
          .when(
              data: (tweets) {
                return ListView.builder(
                  itemCount: tweets.length,
                  itemBuilder: (context, index){
                    final tweet = tweets[index];
                    return TweetCard(tweet: tweet);
                  },
                );
              },
              error: (error, StackTrace) =>
                  Center(child: ErrorText(error: error.toString())),
              loading: () => Center(child: Loader())),
    );
  }
}
