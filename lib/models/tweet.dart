class Tweet{
  final String tweet;
  final String? imageLink;
  final String tweetId;
  final String uid;
  final List likes;
  final List retweets;
  final String? parentId;
  final bool isThread;
  final String postedAt;
  final String profilePic;

//<editor-fold desc="Data Methods">
  const Tweet({
    required this.tweet,
    this.imageLink,
    required this.tweetId,
    required this.uid,
    required this.likes,
    required this.retweets,
    this.parentId,
    required this.isThread,
    required this.postedAt,
    required this.profilePic,
  });


  Tweet copyWith({
    String? tweet,
    String? imageLink,
    String? tweetId,
    String? uid,
    List? likes,
    List? retweets,
    String? parentId,
    bool? isThread,
    String? postedAt,
    String? profilePic,
  }) {
    return Tweet(
      tweet: tweet ?? this.tweet,
      imageLink: imageLink ?? this.imageLink,
      tweetId: tweetId ?? this.tweetId,
      uid: uid ?? this.uid,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      parentId: parentId ?? this.parentId,
      isThread: isThread ?? this.isThread,
      postedAt: postedAt ?? this.postedAt,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tweet': this.tweet,
      'imageLink': this.imageLink,
      'tweetId': this.tweetId,
      'uid': this.uid,
      'likes': this.likes,
      'retweets': this.retweets,
      'parentId': this.parentId,
      'isThread': this.isThread,
      'postedAt': this.postedAt,
      'profilePic': this.profilePic,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweet: map['tweet'] as String,
      imageLink: map['imageLink'] as String,
      tweetId: map['tweetId'] as String,
      uid: map['uid'] as String,
      likes: map['likes'] as List,
      retweets: map['retweets'] as List,
      parentId: map['parentId'] as String,
      isThread: map['isThread'] as bool,
      postedAt: map['postedAt'] as String,
      profilePic: map['profilePic'] as String,
    );
  }

//</editor-fold>
}