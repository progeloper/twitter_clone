import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:giphy_picker/giphy_picker.dart';
import 'package:twitter_clone/core/common/utils.dart';
import 'package:twitter_clone/core/common/widgets/rounded_filled_button.dart';
import 'package:twitter_clone/core/constants/external_apiKeys.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/tweets/controller/tweet_controller.dart';
import 'package:twitter_clone/models/user.dart';

import '../../../theme/palette.dart';

class CreateTweetScreen extends ConsumerStatefulWidget {
  const CreateTweetScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends ConsumerState<CreateTweetScreen> {
  late TextEditingController _controller;
  bool canTweet = false;
  List<File> images = [];
  GiphyGif? gif;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()
      ..addListener(() {
        if (_controller.text.isNotEmpty) {
          setState(() {
            canTweet = true;
          });
        } else {
          setState(() {
            canTweet = false;
          });
        }
      });
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  void selectImage() async {
    final result = await pickImage();
    if (result.isNotEmpty) {
      setState(() {
        images = result;
      });
    }
  }

  void uploadTweet(BuildContext context, WidgetRef ref, User user) {
    if (_controller.text.isNotEmpty) {
      ref.read(tweetControllerProvider.notifier).uploadTweet(
          tweet: _controller.text.trim(),
          user: user,
          context: context,
          files: images);
    }
  }

  void selectGif() async {
    setState(() async {
      gif = await GiphyPicker.pickGif(
          context: context, apiKey: ExternalKeys.giphyKey);
    });
  }

  void goBack() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: () => goBack(),
                      icon: const Icon(Icons.close),
                    ),
                    Expanded(child: Container()),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4,
                      child: canTweet
                          ? IconButton(
                              onPressed: () {},
                              icon: RoundedFilledButton(
                                  function: () {
                                    uploadTweet(context, ref, user!);
                                    Navigator.pop(context);
                                  },
                                  label: 'Tweet'),
                            )
                          : Container(),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextField(
                    controller: _controller,
                    maxLength: 256,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      filled: false,
                      hintText: 'What\'s happening?',
                      hintStyle: TextStyle(
                        color: Palette.darkGreyColor,
                        fontSize: 18,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  child: (images.isEmpty)
                      ? (gif == null)
                          ? Container()
                          : AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Image.network(gif!.images.original!.url!),
                            )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return AspectRatio(
                              aspectRatio: 487 / 451,
                              child: Image.file(images[index]),
                            );
                          },
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      onPressed: selectImage,
                      icon: const Icon(
                        Icons.photo_outlined,
                        color: Palette.blueColor,
                        size: 40,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    IconButton(
                      onPressed: () => selectGif(),
                      icon: const Icon(
                        Icons.gif_box_outlined,
                        color: Palette.blueColor,
                        size: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
