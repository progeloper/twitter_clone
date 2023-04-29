import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/theme/palette.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  void logOut(BuildContext context, WidgetRef ref){
    ref.read(authControllerProvider.notifier).logOut(context);
  }

  void deactivate(BuildContext context, WidgetRef ref, String uid){
    ref.read(authControllerProvider.notifier).deactivate(context, uid);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final user = ref.read(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        title: Text(
          'Settings',
          style: TextStyle(
            color: theme.colorScheme.onPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            onTap: ()=>logOut(context, ref),
            leading: Icon(
              Icons.logout,
              color: theme.colorScheme.onBackground,
            ),
            title: Text(
              'Log out',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            onTap: ()=>deactivate(context, ref, user!.uid),
            leading: Icon(
              Icons.delete,
              color: theme.colorScheme.onBackground,
            ),
            title: Text(
              'Deactivate',
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
