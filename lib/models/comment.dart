class Comment {
  final String comment;
  final String? imageLink;
  final String commentId;
  final String uid;
  final List likes;
  final List retweets;
  final String postedAt;
  final String profilePic;
  final String username;
  final String name;
  final int commentCount;
  final bool isThread;
  final String parentId;

//<editor-fold desc="Data Methods">
  const Comment({
    required this.comment,
    this.imageLink,
    required this.commentId,
    required this.uid,
    required this.likes,
    required this.retweets,
    required this.postedAt,
    required this.profilePic,
    required this.username,
    required this.name,
    required this.commentCount,
    required this.isThread,
    required this.parentId,
  });


  Comment copyWith({
    String? comment,
    String? imageLink,
    String? commentId,
    String? uid,
    List? likes,
    List? retweets,
    String? postedAt,
    String? profilePic,
    String? username,
    String? name,
    int? commentCount,
    bool? isThread,
    String? parentId,
  }) {
    return Comment(
      comment: comment ?? this.comment,
      imageLink: imageLink ?? this.imageLink,
      commentId: commentId ?? this.commentId,
      uid: uid ?? this.uid,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      postedAt: postedAt ?? this.postedAt,
      profilePic: profilePic ?? this.profilePic,
      username: username ?? this.username,
      name: name ?? this.name,
      commentCount: commentCount ?? this.commentCount,
      isThread: isThread ?? this.isThread,
      parentId: parentId ?? this.parentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': this.comment,
      'imageLink': this.imageLink,
      'commentId': this.commentId,
      'uid': this.uid,
      'likes': this.likes,
      'retweets': this.retweets,
      'postedAt': this.postedAt,
      'profilePic': this.profilePic,
      'username': this.username,
      'name': this.name,
      'commentCount': this.commentCount,
      'isThread': this.isThread,
      'parentId': this.parentId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      comment: map['comment'] as String,
      imageLink: map['imageLink'] as String?,
      commentId: map['commentId'] as String,
      uid: map['uid'] as String,
      likes: map['likes'] as List,
      retweets: map['retweets'] as List,
      postedAt: map['postedAt'] as String,
      profilePic: map['profilePic'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      commentCount: map['commentCount'] as int,
      isThread: map['isThread'] as bool,
      parentId: map['parentId'] as String,
    );
  }

//</editor-fold>
}
