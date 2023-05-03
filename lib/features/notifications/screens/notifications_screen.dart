import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/features/auth/controller/auth_controller.dart';
import 'package:twitter_clone/features/notifications/controller/notification_controller.dart';
import 'package:twitter_clone/theme/palette.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final user = ref.watch(userProvider);
    return ref.watch(fetchUserNotificationsProvider(user!.uid)).when(
          data: (notifications) {
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  tileColor: theme.colorScheme.background,
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(notification.profilePic),
                  ),
                  title: Text(
                    notification.title,
                    style: TextStyle(
                      color: theme.colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(
            child: ErrorText(error: error.toString()),
          ),
          loading: () => const Center(child: Loader()),
        );
  }
}
