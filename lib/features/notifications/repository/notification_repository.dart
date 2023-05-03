import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/core/constants/firebase_constants.dart';
import 'package:twitter_clone/core/providers/firebase_providers.dart';
import 'package:twitter_clone/models/notification.dart';

final notificationRepositoryProvider = Provider((ref) {
  final firestore = ref.read(firestoreProvider);
  return NotificationRepository(firestore: firestore);
});

class NotificationRepository {
  final FirebaseFirestore _firestore;
  NotificationRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _notifications =>
      _firestore.collection(FirebaseConstants.notificationsCollection);

  Stream<List<Notification>> fetchUserNotifications(String uid) {
    return _notifications
        .where('uid', isEqualTo: uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map((e) => Notification.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }
}
