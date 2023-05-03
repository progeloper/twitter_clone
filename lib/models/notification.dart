class Notification{
  final String profilePic;
  final String name;
  final String title;
  final String notifId;
  final String uid;
  final String mutualId;
  final String time;

//<editor-fold desc="Data Methods">
  const Notification({
    required this.profilePic,
    required this.name,
    required this.title,
    required this.notifId,
    required this.uid,
    required this.mutualId,
    required this.time,
  });

  Notification copyWith({
    String? profilePic,
    String? name,
    String? title,
    String? notifId,
    String? uid,
    String? mutualId,
    String? time,
  }) {
    return Notification(
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      title: title ?? this.title,
      notifId: notifId ?? this.notifId,
      uid: uid ?? this.uid,
      mutualId: mutualId ?? this.mutualId,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profilePic': this.profilePic,
      'name': this.name,
      'title': this.title,
      'notifId': this.notifId,
      'uid': this.uid,
      'mutualId': this.mutualId,
      'time': this.time,
    };
  }

  factory Notification.fromMap(Map<String, dynamic> map) {
    return Notification(
      profilePic: map['profilePic'] as String,
      name: map['name'] as String,
      title: map['title'] as String,
      notifId: map['notifId'] as String,
      uid: map['uid'] as String,
      mutualId: map['mutualId'] as String,
      time: map['time'] as String,
    );
  }

//</editor-fold>
}