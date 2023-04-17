import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:intl/intl.dart';
import 'package:twitter_clone/core/constants/constants.dart';
import 'package:twitter_clone/features/auth/repository/auth_repository.dart';
import 'package:twitter_clone/models/user.dart';

import '../../../core/common/utils.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final AuthRepository repo = ref.read(authRepoProvider);
  return AuthController(repo: repo, ref: ref);
});

final userProvider = StateProvider<User?>((ref) => null);

final authStateChangeProvider = StreamProvider((ref){
  final authController = ref.read(authControllerProvider.notifier);
  return authController.authStateChanges;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repo;
  final Ref _ref;
  AuthController({required AuthRepository repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(false);

  Stream<auth.User?> get authStateChanges => _repo.authStateChange;

  Stream<User> getUserData(String uid){
    return _repo.getUserData(uid);
  }

  void signup({
    required BuildContext context,
    required String name,
    required String email,
    required String dob,
    required String password,
  }) async {
    state = true;
    final user = await _repo.signUp(
        name: name,
        email: email,
        dob: dob,
        password: password,
        banner: Constants.defaultBanner,
        displayPic: Constants.defaultAvatar,
        bio: 'Hi there, I use twitter',
        url: 'www.twitter.com',
        joined: DateFormat('dd MMMM yyyy').format(DateTime.now()),
        location: 'Twitter Hq');
    state = false;
    user.fold((l) => showSnackBar(context, l.error), (r) {
      showSnackBar(context, '${r.username} signed up successfully');
      _ref.read(userProvider.notifier).update((state) => r);
    });
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    final user = await _repo.login(email: email, password: password);
    user.fold((l) => showSnackBar(context, l.error), (r) {
      _ref.read(userProvider.notifier).update((state) => r);
    });
  }
}
