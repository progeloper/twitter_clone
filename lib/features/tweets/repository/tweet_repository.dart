import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/comment.dart';
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

  CollectionReference get _comments =>
      _firestore.collection(FirebaseConstants.commentsCollectiion);

  FutureVoid uploadTweet(Tweet tweet) async {
    try {
      return right(_tweets.doc(tweet.tweetId).set(tweet.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid uploadComment(Comment comment) async {
    try {
      _tweets.doc(comment.parentId).update({
        'commentCount' : FieldValue.increment(1),
      });
      return right(_comments.doc(comment.commentId).set(comment.toMap()));
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

  Stream<List<Comment>> fetchTweetComments(String tweetId) {
    return _comments
        .where('parentId', isEqualTo: tweetId)
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Comment.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<User>> getUsersFollowing(String id) {
    return _users
        .where('followers', arrayContains: id)
        .snapshots()
        .map((event) {
      List<User> users = [];
      for (var doc in event.docs) {
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
      for (var doc in event.docs) {
        users.add(User.fromMap(doc.data() as Map<String, dynamic>));
      }
      return users;
    });
  }

  FutureVoid likeTweet(Tweet tweet, String likerId)async{
    try{
      if(!tweet.likes.contains(likerId)) {
        return right(await _tweets.doc(tweet.tweetId).update({
          'likes': FieldValue.arrayUnion([likerId]),
        }));
      }else{
        return right(await _tweets.doc(tweet.tweetId).update({
          'likes': FieldValue.arrayRemove([likerId]),
        }));
      }
    }on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  FutureVoid retweetTweet(Tweet tweet, String userId)async{
    try{
      if(!tweet.retweets.contains(userId)) {
        return right(await _tweets.doc(tweet.tweetId).update({
          'retweets': FieldValue.arrayUnion([userId]),
        }));
      }else{
        return right(await _tweets.doc(tweet.tweetId).update({
          'retweets': FieldValue.arrayRemove([userId]),
        }));
      }
    }on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  FutureVoid likeComment(Comment comment, String likerId)async{
    try{
      if(!comment.likes.contains(likerId)) {
        return right(await _comments.doc(comment.commentId).update({
          'likes': FieldValue.arrayUnion([likerId]),
        }));
      }else{
        return right(await _comments.doc(comment.commentId).update({
          'likes': FieldValue.arrayRemove([likerId]),
        }));
      }
    }on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  FutureVoid retweetComment(Comment comment, String userId)async{
    try{
      if(!comment.retweets.contains(userId)) {
        return right(await _comments.doc(comment.commentId).update({
          'retweets': FieldValue.arrayUnion([userId]),
        }));
      }else{
        return right(await _comments.doc(comment.commentId).update({
          'retweets': FieldValue.arrayRemove([userId]),
        }));
      }
    }on FirebaseException catch (e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  Stream<Tweet> getTweetFromId(String id) {
    return _tweets
        .doc(id)
        .snapshots()
        .map((event) => Tweet.fromMap(event.data() as Map<String, dynamic>));
  }
}
