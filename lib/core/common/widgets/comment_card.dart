import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitter_clone/features/profiles/screens/profile_screen.dart';
import 'package:twitter_clone/features/tweets/screens/create_tweet_screen.dart';
import 'package:twitter_clone/theme/palette.dart';

import '../../../features/auth/controller/auth_controller.dart';
import '../../../features/tweets/controller/tweet_controller.dart';
import '../../../models/comment.dart';
import '../../../models/user.dart';


class CommentCard extends ConsumerStatefulWidget {
  final Comment comment;
  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  ConsumerState createState() => _CommentCardState();
}

class _CommentCardState extends ConsumerState<CommentCard> {
  Future<User> getTweeter(WidgetRef ref) async {
    final tweeter = await ref
        .read(authControllerProvider.notifier)
        .getUserData(widget.comment.uid)
        .first;
    return tweeter;
  }

  void likeComment(BuildContext context, WidgetRef ref, String userId) async {
    ref
        .read(tweetControllerProvider.notifier)
        .likeComment(widget.comment, userId, context);
    setState(() {});
  }

  void retweetComment(BuildContext context, WidgetRef ref, String userId) async {
    ref
        .read(tweetControllerProvider.notifier)
        .retweetComment(widget.comment, userId, context);
    setState(() {});
  }

  Widget getImages(Comment comment){
    if(comment.imageLink.length == 1) {
      return Image.network(comment.imageLink[0]);
    } else if(comment.imageLink.length == 2) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Image.network(
              comment.imageLink[0],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Image.network(
              comment.imageLink[1],
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }
    else if(comment.imageLink.length == 3) {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: Image.network(
                comment.imageLink[0],
                fit: BoxFit.cover,
              )),
          const SizedBox(
            width: 2,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Image.network(
                      comment.imageLink[1],
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 2,
                ),
                Expanded(
                    child: Image.network(
                        comment.imageLink[2])),
              ],
            ),
          ),
        ],
      );
    }
    else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Expanded(
                child: Image.network(
                  comment.imageLink[0],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  comment.imageLink[1],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 2,
          ),
          Column(
            children: [
              Expanded(
                child: Image.network(
                  comment.imageLink[2],
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Image.network(
                  comment.imageLink[3],
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeProvider);
    final comment = widget.comment;
    final user = ref.read(userProvider);

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
          GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen(uid: comment.uid)));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage(comment.profilePic),
              radius: 30,
            ),
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
                SizedBox(
                  height: 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: comment.name,
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
                const SizedBox(
                  height: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.comment,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5,),
                    if (comment.imageLink != null)
                      Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: getImages(comment),
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateTweetScreen()));
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.comment,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                            Text(
                              comment.commentCount.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: ()=>retweetComment(context, ref, user.uid),
                              icon: (comment.retweets.contains(user!.uid))
                                  ? const FaIcon(
                                FontAwesomeIcons.retweet,
                                color: Palette.greenColor,
                              )
                                  : const FaIcon(
                                FontAwesomeIcons.retweet,
                                color: Palette.darkGreyColor,
                              ),
                            ),
                            Text(
                              comment.retweets.length.toString(),
                              style:  TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () =>
                                  likeComment(context, ref, user.uid),
                              icon: (comment.likes.contains(user!.uid))
                                  ? const FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Palette.redColor,
                              )
                                  : const FaIcon(
                                FontAwesomeIcons.heart,
                                color: Palette.darkGreyColor,
                              ),
                            ),
                            Text(
                              comment.likes.length.toString(),
                              style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w300,
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.share_outlined,
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


