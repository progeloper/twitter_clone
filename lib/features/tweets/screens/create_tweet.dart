import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/common/widgets/rounded_filled_button.dart';

class CreateTweet extends ConsumerWidget {
  const CreateTweet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: MediaQuery.of(context).size.width/4,
                  child: IconButton(
                    onPressed: () {},
                    icon: RoundedFilledButton(function: () {}, label: 'Tweet'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
