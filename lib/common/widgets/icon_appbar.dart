import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconAppBar extends ConsumerWidget {
  const IconAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Image.asset('bird_icon.png'),
      centerTitle: true,
    );
  }
}