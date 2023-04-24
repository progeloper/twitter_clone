import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../tweets/screens/create_tweet_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _FeedScreenState();
}

void navigateToCreateTweetScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => CreateTweetScreen()));

}
class _FeedScreenState extends ConsumerState<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToCreateTweetScreen(context),
        child: const FaIcon(FontAwesomeIcons.paperPlane,),
      ),
      body: Container(),
    );
  }
}
