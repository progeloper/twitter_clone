import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/core/providers/storage_repository_provider.dart';
import 'package:twitter_clone/features/tweets/repository/tweet_repository.dart';
import 'package:twitter_clone/models/tweet.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:uuid/uuid.dart';

import '../../../core/common/utils.dart';

final tweetControllerProvider =
    StateNotifierProvider<TweetControllerNotifier, bool>((ref) {
  final repo = ref.read(tweetRepositoryProvider);
  final storageRepo = ref.read(storageRepoProvider);
  return TweetControllerNotifier(repo: repo, storageRepo: storageRepo);
});

final fetchUserFeedProvider = StreamProvider.family((ref, List<String> tweeters){
  final controller = ref.read(tweetControllerProvider.notifier);
  return controller.fetchUserFeed(tweeters);
});

class TweetControllerNotifier extends StateNotifier<bool> {
  final TweetRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  TweetControllerNotifier({required TweetRepository repo, required FirebaseStorageRepository storageRepo})
      : _repo = repo,
        _storageRepo = storageRepo,
        super(false);

  void uploadTweet(
      {required String tweet,
      required User user,
        File? file,
      required BuildContext context}) async {
    final tweetId = const Uuid().v1();
    final String postedAt = DateFormat('dd MMMM yyyy').format(DateTime.now());
    String? imageLink;
    if(file != null){
      final upload = await _storageRepo.storeFile('tweets/${tweetId}', tweetId, file);
      upload.fold((l) => showSnackBar(context, 'An error occurred'), (r){imageLink = r;});
    }
    final model = Tweet(
        tweet: tweet,
        tweetId: tweetId,
        uid: user.uid,
        likes: [],
        retweets: [],
        isThread: false,
        imageLink: imageLink,
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

  Stream<List<Tweet>> fetchUserFeed(List<String> tweeters){
    if (tweeters.isNotEmpty){
      return _repo.fetchUserFeed(tweeters);
    }
    return Stream.value([]);
  }

}
