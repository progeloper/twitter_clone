import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/failure.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/user.dart' as model;

final authRepoProvider = Provider((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final firestore = ref.read(firestoreProvider);
  return AuthRepository(auth: auth, firestore: firestore);
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore firestore})
      : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  FutureEither<model.User> signUp({
    required String name,
    required String email,
    required String dob,
    required String password,
    required String banner,
    required String displayPic,
    required String bio,
    required String url,
    required String joined,
    required String location,
  }) async {
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      model.User user = model.User(
          email: email,
          name: name,
          username: '${name.substring(0, 3)}${cred.user!.uid.substring(0, 2)}',
          uid: cred.user!.uid,
          displayPic: displayPic,
          banner: banner,
          bio: bio,
          location: location,
          url: url,
          joined: joined,
          dob: dob,
          followers: [],
          following: []);
      await _users.doc(user.uid).set(user.toMap());
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<model.User> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      model.User user = await getUserData(cred.user!.uid).first;
      return right(user);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid logOut() async {
    try {
      return right(await _auth.signOut());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureVoid deactivateAccunt(String uid)async{
    try {
      await _auth.signOut();
      return right(await _users.doc(uid).delete());
    } on FirebaseException catch (e) {
    throw e.message!;
    } catch (e) {
    return left(Failure(e.toString()));
    }
  }

  Stream<model.User> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => model.User.fromMap(event.data() as Map<String, dynamic>));
  }

  Stream<User?> get authStateChange => _auth.authStateChanges();
}
