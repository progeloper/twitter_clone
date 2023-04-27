import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';

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
}
