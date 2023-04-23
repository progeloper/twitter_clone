import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/tweet.dart';

final tweetRepositoryProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  final auth = ref.read(firebaseAuthProvider);
  return TweetRepository(auth: auth, firestore: firestore);
});

class TweetRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  const TweetRepository(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  CollectionReference get _tweets => _firestore.collection(FirebaseConstants.tweetsCollection);

  FutureVoid uploadTweet(Tweet tweet)async{
    try{
      return right(_tweets.doc(tweet.tweetId).set(tweet.toMap()));
    } on FirebaseException catch(e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }
}
