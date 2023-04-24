import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/features/tweets/repository/tweet_repository.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/utils.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetControllerNotifier, bool>((ref) {
  final repo = ref.read(tweetRepositoryProvider);
  return TweetControllerNotifier(repo: repo);
});

class TweetControllerNotifier extends StateNotifier<bool> {
  final TweetRepository _repo;
  TweetControllerNotifier({required TweetRepository repo})
      : _repo = repo,
        super(false);

  void uploadTweet(
      {required String tweet,
      required User user,
      required BuildContext context}) async {
    final tweetId = const Uuid().v1();
    final String postedAt = DateFormat('dd MMMM yyyy').format(DateTime.now());
    final model = Tweet(
        tweet: tweet,
        tweetId: tweetId,
        uid: user.uid,
        likes: [],
        retweets: [],
        isThread: false,
        postedAt: postedAt,
        profilePic: user.displayPic,
        username: user.username,
        name: user.name,
        commentCount: 0);
    state = true;
    final res = await _repo.uploadTweet(model);
    state = false;
    res.fold((l) => showSnackBar(context, l.toString()),
        (r) => showSnackBar(context, 'Tweet sent'));
  }
}
