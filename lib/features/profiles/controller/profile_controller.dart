import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/providers/storage_repository_provider.dart';
import 'package:twitter_clone/features/profiles/repository/profile_repository.dart';
import 'package:twitter_clone/models/comment.dart';

import '../../../core/common/utils.dart';
import '../../../models/tweet.dart';
import '../../../models/user.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  final repo = ref.read(profileRepositoryProvider);
  final storageRepo = ref.read(storageRepoProvider);
  return ProfileController(repo: repo, storageRepo: storageRepo);
});

final getProfileByIdProvider = StreamProvider.family((ref, String id) {
  return ref.read(profileControllerProvider.notifier).getProfileById(id);
});

final getUserTweetsProvider = StreamProvider.family((ref, String uid) {
  return ref.read(profileControllerProvider.notifier).getProfileTweets(uid);
});

final getUserCommentsProvider = StreamProvider.family((ref, String uid) {
  return ref.read(profileControllerProvider.notifier).getProfileComments(uid);
});

final getProfileLikedTweetsProvider = StreamProvider.family((ref, String uid) {
  return ref
      .read(profileControllerProvider.notifier)
      .getProfileLikedTweets(uid);
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _repo;
  final FirebaseStorageRepository _storageRepo;
  ProfileController(
      {required ProfileRepository repo,
      required FirebaseStorageRepository storageRepo})
      : _repo = repo,
        _storageRepo = storageRepo,
        super(false);

  Stream<User> getProfileById(String id) {
    return _repo.getProfileById(id);
  }

  void followUser(User other, User currentUser, BuildContext context) async {
    final res = await _repo.followUser(other, currentUser);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => null);
  }

  Stream<List<Tweet>> getProfileTweets(String uid) {
    return _repo.getProfileTweets(uid);
  }

  Stream<List<Comment>> getProfileComments(String uid) {
    return _repo.getProfileComments(uid);
  }

  Stream<List<Tweet>> getProfileLikedTweets(String uid) {
    return _repo.getProfileLikedTweets(uid);
  }

  void editProfile({
    required User user,
    required BuildContext context,
    String? name,
    String? bio,
    String? location,
    String? url,
    Uint8List? banner,
    Uint8List? profileImage,
  }) async {
    state = true;
    if(banner != null){
      final link = await _storageRepo.storeImage('users/banners', user.uid, banner);
      String? url;
      link.fold((l) => showSnackBar(context, l.error), (r){url = r;});
      user = user.copyWith(banner: url);
    }
    if(profileImage != null){
      final link = await _storageRepo.storeImage('users/profileImages', user.uid, profileImage);
      String? url;
      link.fold((l) => showSnackBar(context, l.error), (r){url = r;});
      user = user.copyWith(displayPic: url);
    }
    user = user.copyWith(
      name: name,
      bio: bio,
      location: location,
      url: url,
    );
    final res = await _repo.editProfile(user);
    res.fold((l) => showSnackBar(context, 'An error occurred'), (r) => showSnackBar(context, 'Details updated successfully'));
  }
}
