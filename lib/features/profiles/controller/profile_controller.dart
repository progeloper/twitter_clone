import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/providers/storage_repository_provider.dart';
import 'package:twitter_clone/features/profiles/repository/profile_repository.dart';

import '../../../core/common/utils.dart';
import '../../../models/user.dart';


final profileControllerProvider = StateNotifierProvider<ProfileController, bool>((ref) {
  final repo = ref.read(profileRepositoryProvider);
  final storageRepo = ref.read(storageRepoProvider);
  return ProfileController(repo: repo, storageRepo: storageRepo);
});

final getProfileByIdProvider = StreamProvider.family((ref, String id) {
  return ref.read(profileControllerProvider.notifier).getProfileById(id);
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  ProfileController(
      {required ProfileRepository repo,
      required FirebaseStorageRepository storageRepo})
      : _repo = repo,
        _storageRepo = storageRepo, super(false);


  Stream<User> getProfileById(String id){
    return _repo.getProfileById(id);
  }

  void followUser(User other, User currentUser, BuildContext context)async{
    final res = await _repo.followUser(other, currentUser);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }

}
