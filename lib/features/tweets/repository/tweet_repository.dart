import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/tweet.dart';

import '../../../models/user.dart';

final tweetRepositoryProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return TweetRepository(auth: auth, firestore: firestore);
});

class TweetRepository {
  final auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  const TweetRepository(
      {required auth.FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  CollectionReference get _tweets =>
      _firestore.collection(FirebaseConstants.tweetsCollection);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureVoid uploadTweet(Tweet tweet) async {
    try {
      return right(_tweets.doc(tweet.tweetId).set(tweet.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Tweet>> fetchUserFeed(List<User> tweeters) {
    return _tweets
        .where('uid', whereIn: tweeters.map((e) => e.uid).toList())
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Tweet.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<User>> getUsersFollowing(String id) {
    return _users
        .where('following', arrayContains: id)
        .snapshots()
        .map((event) {
          List<User> users = [];
          for(var doc in event.docs){
            users.add(User.fromMap(doc.data() as Map<String, dynamic>));
          }
          return users;
    });
  }

  Stream<List<User>> getUsersFollowers(String id) {
    return _users
        .where('followers', arrayContains: id)
        .snapshots()
        .map((event) {
      List<User> users = [];
      for(var doc in event.docs){
        users.add(User.fromMap(doc.data() as Map<String, dynamic>));
      }
      return users;
    });
  }
}
