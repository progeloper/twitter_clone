import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';


final authRepoProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthRepository(auth: auth, firestore: firestore);
});

class AuthRepository{
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({required FirebaseAuth auth, required FirebaseFirestore firestore}) : _auth = auth, _firestore = firestore;

  CollectionReference get _users => _firestore.collection('collectionPath');


}
