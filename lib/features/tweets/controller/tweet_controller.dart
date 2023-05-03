import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/core/providers/storage_repository_provider.dart';
import 'package:twitter_clone/features/tweets/repository/tweet_repository.dart';
import 'package:twitter_clone/models/comment.dart';
import 'package:twitter_clone/models/notification.dart' as notif;
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

final fetchUserFeedProvider = StreamProvider.family((ref, List<User> tweeters) {
  final controller = ref.read(tweetControllerProvider.notifier);
  return controller.fetchUserFeed(tweeters);
});

final fetchTweetCommentsProvider = StreamProvider.family((ref, String tweetId) {
  return ref.read(tweetControllerProvider.notifier).fetchTweetComments(tweetId);
});

final getUsersFollowingProvider = StreamProvider.family((ref, String id) {
  final controller = ref.read(tweetControllerProvider.notifier);
  return controller.getUsersFollowing(id);
});

final getUsersFollowersProvider = StreamProvider.family((ref, String id) {
  final controller = ref.read(tweetControllerProvider.notifier);
  return controller.getUsersFollowers(id);
});

final tweetFromIdProvider = StreamProvider.family((ref, String id) {
  return ref.read(tweetControllerProvider.notifier).getTweetFromId(id);
});

class TweetControllerNotifier extends StateNotifier<bool> {
  final TweetRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  TweetControllerNotifier(
      {required TweetRepository repo,
      required FirebaseStorageRepository storageRepo})
      : _repo = repo,
        _storageRepo = storageRepo,
        super(false);

  void uploadTweet(
      {required String tweet,
      required User user,
      required List<File> files,
      required BuildContext context}) async {
    final tweetId = const Uuid().v1();
    final String postedAt = DateFormat('dd MMMM yyyy').format(DateTime.now());
    List<String> imageLink = [];
    if (files.isNotEmpty) {
      for (int i = 0; i < files.length; i++) {
        final upload = await _storageRepo.storeFile(
            'tweets/$tweetId${i.toString()}', tweetId, files[i]);
        upload.fold((l) => showSnackBar(context, 'An error occurred'), (r) {
          imageLink.add(r);
        });
      }
    }
    final model = Tweet(
        tweet: tweet,
        tweetId: tweetId,
        uid: user.uid,
        likes: [],
        retweets: [],
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

  void uploadComment(
      {required String commentText,
      required User user,
      required String tweetId,
      required List<File> files,
      required BuildContext context}) async {
    final commentId = const Uuid().v1();
    final String postedAt = DateFormat('dd MMMM yyyy').format(DateTime.now());
    List<String> imageLink = [];
    if (files.isNotEmpty) {
      for (int i = 0; i < files.length; i++) {
        final upload = await _storageRepo.storeFile(
            'tweets/$commentId${i.toString()}', commentId, files[i]);
        upload.fold((l) => showSnackBar(context, 'An error occurred'), (r) {
          imageLink.add(r);
        });
      }
    }
    final model = Comment(
        comment: commentText,
        commentId: commentId,
        uid: user.uid,
        likes: [],
        retweets: [],
        imageLink: imageLink,
        postedAt: postedAt,
        profilePic: user.displayPic,
        username: user.username,
        name: user.name,
        commentCount: 0,
        isThread: false,
        parentId: tweetId);
    state = true;
    final res = await _repo.uploadComment(model);
    state = false;
    res.fold((l) => showSnackBar(context, l.toString()),
        (r) => showSnackBar(context, 'Tweet sent'));
  }

  Stream<List<Tweet>> fetchUserFeed(List<User> tweeters) {
    if (tweeters.isNotEmpty) {
      return _repo.fetchUserFeed(tweeters);
    }
    return Stream.value([]);
  }

  Stream<List<Comment>> fetchTweetComments(String tweetId) {
    return _repo.fetchTweetComments(tweetId);
  }

  Stream<List<User>> getUsersFollowing(String id) {
    return _repo.getUsersFollowing(id);
  }

  Stream<List<User>> getUsersFollowers(String id) {
    return _repo.getUsersFollowers(id);
  }

  Stream<Tweet> getTweetFromId(String id) {
    return _repo.getTweetFromId(id);
  }

  void likeTweet(Tweet tweet, User liker, BuildContext context) async {
    notif.Notification notification = notif.Notification(
      profilePic: liker.displayPic,
      name: liker.name,
      title: '${liker.name} liked your tweet',
      notifId: const Uuid().v1(),
      uid: tweet.uid,
      mutualId: liker.uid,
      time: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    );
    final res = await _repo.likeTweet(tweet, liker.uid, notification);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }

  void retweetTweet(Tweet tweet, User user, BuildContext context) async {
    notif.Notification notification = notif.Notification(
      profilePic: user.displayPic,
      name: user.name,
      title: '${user.name} retweeted your tweet',
      notifId: const Uuid().v1(),
      uid: tweet.uid,
      mutualId: user.uid,
      time: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    );
    final res = await _repo.retweetTweet(tweet, user.uid, notification);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }

  void likeComment(Comment comment, User liker, BuildContext context) async {
    notif.Notification notification = notif.Notification(
      profilePic: liker.displayPic,
      name: liker.name,
      title: '${liker.name} liked your reply',
      notifId: const Uuid().v1(),
      uid: comment.uid,
      mutualId: liker.uid,
      time: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    );
    final res = await _repo.likeComment(comment, liker.uid, notification);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }

  void retweetComment(
      Comment comment, User user, BuildContext context) async {
    notif.Notification notification = notif.Notification(
      profilePic: user.displayPic,
      name: user.name,
      title: '${user.name} retweeted your reply',
      notifId: const Uuid().v1(),
      uid: comment.uid,
      mutualId: user.uid,
      time: DateFormat('dd MMMM yyyy').format(DateTime.now()),
    );
    final res = await _repo.retweetComment(comment, user.uid, notification);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }
}
