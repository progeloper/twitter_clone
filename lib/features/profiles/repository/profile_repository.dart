import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/comment.dart';

import '../../../models/tweet.dart';
import '../../../models/user.dart';

final profileRepositoryProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return ProfileRepository(firestore: firestore);
});

class ProfileRepository {
  final FirebaseFirestore _firestore;
  const ProfileRepository({
    required FirebaseFirestore firestore,
  }) : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  CollectionReference get _tweets =>
      _firestore.collection(FirebaseConstants.tweetsCollection);

  CollectionReference get _comments =>
      _firestore.collection(FirebaseConstants.commentsCollectiion);

  Stream<User> getProfileById(String id) {
    return _users
        .doc(id)
        .snapshots()
        .map((event) => User.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureVoid followUser(String otherId, User currentUser) async {
    try {
      if (currentUser.following.contains(otherId)) {
        _users.doc(otherId).update({
          'followers': FieldValue.arrayRemove([currentUser.uid]),
        });
        return right(_users.doc(currentUser.uid).update({
          'following': FieldValue.arrayRemove([otherId]),
        }));
      } else {
        _users.doc(otherId).update({
          'followers': FieldValue.arrayUnion([currentUser.uid]),
        });
        return right(_users.doc(currentUser.uid).update({
          'following': FieldValue.arrayUnion([otherId]),
        }));
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Tweet>> getProfileTweets(String uid) {
    return _tweets
        .where('uid', isEqualTo: uid)
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Tweet.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<Comment>> getProfileComments(String uid) {
    return _comments
        .where('uid', isEqualTo: uid)
        .orderBy('postedAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Comment.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<Tweet>> getProfileLikedTweets(String uid) {
    return _tweets.where('likes', arrayContains: uid).snapshots().map((event) =>
        event.docs
            .map((e) => Tweet.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
  
  FutureVoid editProfile(User user)async{
    try{
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch(e){
      throw e.message!;
    } catch (e){
      return left(Failure(e.toString()));
    }
  }

  Stream<List<User>> searchProfilesByUsername(String query){
    return _users.where('username', isGreaterThanOrEqualTo: query).snapshots().map((event) => event.docs.map((e) => User.fromMap(e.data() as Map<String, dynamic>)).toList());
  }
  
}
