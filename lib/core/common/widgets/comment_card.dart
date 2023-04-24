import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../features/auth/controller/auth_controller.dart';
import '../../../models/comment.dart';
import '../../../models/user.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  Future<User> getTweeter(WidgetRef ref) async {
    final tweeter = await ref
        .read(authControllerProvider.notifier)
        .getUserData(comment.uid)
        .first;
    return tweeter;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Palette.darkGreyColor, width: 0.5),
            bottom: BorderSide(color: Palette.darkGreyColor, width: 0.5),
          )),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(comment.profilePic),
            radius: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: '${comment.name}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: ' @${comment.username}',
                              style: const TextStyle(
                                color: Palette.darkGreyColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.more_vert,
                          color: Palette.darkGreyColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comment.tweet,
                      ),
                      const SizedBox(height: 5,),
                      if (comment.imageLink != null)
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.network(comment.imageLink!),
                        ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.comment,
                                  color: Palette.darkGreyColor,
                                ),
                              ),
                              Text(
                                comment.commentCount.toString(),
                                style: const TextStyle(
                                  color: Palette.darkGreyColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.retweet,
                                  color: Palette.darkGreyColor,
                                ),
                              ),
                              Text(
                                comment.retweets.length.toString(),
                                style: const TextStyle(
                                  color: Palette.darkGreyColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: FaIcon(
                                  FontAwesomeIcons.heart,
                                  color: Palette.darkGreyColor,
                                ),
                              ),
                              Text(
                                comment.likes.length.toString(),
                                style: const TextStyle(
                                  color: Palette.darkGreyColor,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.shareNodes,
                              color: Palette.darkGreyColor,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
