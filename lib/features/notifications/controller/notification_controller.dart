import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/features/notifications/repository/notification_repository.dart';
import 'package:twitter_clone/models/notification.dart';

final notificationControllerProvider = StateNotifierProvider<NotificationControllerNotifier, bool>((ref) {
  final repo = ref.read(notificationRepositoryProvider);
  return NotificationControllerNotifier(repo: repo);
});

final fetchUserNotificationsProvider = StreamProvider.family((ref, String uid) {
  return ref.watch(notificationControllerProvider.notifier).fetchUserNotifications(uid);
});

class NotificationControllerNotifier extends StateNotifier<bool> {
  final NotificationRepository _repo;
  NotificationControllerNotifier({required NotificationRepository repo}) : _repo = repo,super(false);

  Stream<List<Notification>> fetchUserNotifications(String uid){
    return _repo.fetchUserNotifications(uid);
  }
}