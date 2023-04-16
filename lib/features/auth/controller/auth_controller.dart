import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/features/auth/repository/auth_repository.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final AuthRepository repo = ref.read(authRepoProvider);
  return AuthController(repo: repo, ref: ref);
});

final userProvider = StateProvider((ref) => null);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _repo;
  final Ref _ref;
  AuthController({required AuthRepository repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(false);

  void signup({
    required BuildContext context,
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
    state = true;
    final user = await _repo.signUp(
        name: name,
        email: email,
        dob: dob,
        password: password,
        banner: banner,
        displayPic: displayPic,
        bio: bio,
        url: url,
        joined: joined,
        location: location);
    state = false;
    user.fold((l) => null, (r) => null)
  }
}
