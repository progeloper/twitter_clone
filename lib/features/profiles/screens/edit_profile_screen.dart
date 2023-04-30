import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/common/utils.dart';
import 'package:twitter_clone/core/common/widgets/input_text_field.dart';
import 'package:twitter_clone/features/profiles/controller/profile_controller.dart';
import 'package:twitter_clone/models/user.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../core/common/error_text.dart';
import '../../../core/common/loader.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final String uid;
  const EditProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  ConsumerState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  late TextEditingController _websiteController;
  Uint8List? bannerImage;
  Uint8List? profileImage;

  void saveDetails(BuildContext context, WidgetRef ref, User user) {
    ref.read(profileControllerProvider.notifier).editProfile(
          user: user,
          context: context,
          name: _nameController.text,
          bio: _bioController.text,
          location: _locationController.text,
          url: _websiteController.text,
          banner: bannerImage,
          profileImage: profileImage,
        );
  }

  void selectBannerImage() async {
    bannerImage = await pickOneImage();
    setState(() {

    });
  }

  void selectProfileImage() async {
    profileImage = await pickOneImage();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _locationController = TextEditingController();
    _websiteController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    _websiteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);

    return ref.watch(getProfileByIdProvider(widget.uid)).when(
        data: (profile) {
          _nameController.text = profile.name;
          _bioController.text = profile.bio;
          _locationController.text = profile.location;
          _websiteController.text = profile.url;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: const Text('Edit Community'),
              actions: [
                TextButton(
                  onPressed: ()=>saveDetails(context, ref, profile),
                  child: Text(
                    'Save',
                    style: TextStyle(color: Palette.blueColor),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned.fill(
                          child: (bannerImage == null)
                              ? Image.network(
                                  profile.banner,
                                  fit: BoxFit.fill,
                                )
                              : FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.memory(bannerImage!),
                                ),
                        ),
                        Positioned.fill(
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              color: Palette.blackColor,
                              height: 150,
                              width: double.infinity,
                              child: Center(
                                child: IconButton(
                                  onPressed: selectBannerImage,
                                  icon: const Icon(
                                    Icons.add_a_photo_outlined,
                                    size: 40,
                                    color: Palette.lightGreyColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: -40,
                          child: (profileImage == null)
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(profile.displayPic),
                                  radius: 40,
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(profileImage!),
                                  radius: 40,
                                ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: -40,
                          child: Opacity(
                            opacity: 0.7,
                            child: Container(
                              height: 80,
                              constraints: const BoxConstraints(
                                  minWidth: 80, minHeight: 80),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.blackColor,
                              ),
                              child: IconButton(
                                onPressed: selectProfileImage,
                                icon: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 30,
                                  color: Palette.lightGreyColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        InputTextField(
                            controller: _nameController, label: 'Name'),
                        const SizedBox(
                          height: 10,
                        ),
                        InputTextField(
                            controller: _bioController, label: 'Bio'),
                        const SizedBox(
                          height: 10,
                        ),
                        InputTextField(
                            controller: _locationController, label: 'Location'),
                        const SizedBox(
                          height: 10,
                        ),
                        InputTextField(
                            controller: _websiteController, label: 'Website'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(
              child: ErrorText(error: error.toString()),
            ),
        loading: () => const Center(
              child: Loader(),
            ));
  }
}
