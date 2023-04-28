import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';

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

  Stream<User> getProfileById(String id){
    return _users.doc(id).snapshots().map((event) => User.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureVoid followUser(User other, User currentUser)async{
    try{
      if(currentUser.following.contains(other.uid)){
        _users.doc(other.uid).update({
          'followers': FieldValue.arrayRemove([currentUser.uid]),
        });
        return right(_users.doc(currentUser.uid).update({
          'following': FieldValue.arrayRemove([other.uid]),
        }));
      }else{
        _users.doc(other.uid).update({
          'followers': FieldValue.arrayUnion([currentUser.uid]),
        });
        return right(_users.doc(currentUser.uid).update({
          'following': FieldValue.arrayUnion([other.uid]),
        }));
      }
    } on FirebaseException catch(e){
      throw e.message!;
    } catch(e){
      return left(Failure(e.toString()));
    }
  }
}
