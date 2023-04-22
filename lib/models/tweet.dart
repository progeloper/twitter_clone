class Tweet{
  final String tweet;
  final String imageLink;
  final String tweetId;
  final String uid;
  final List likes;
  final List retweets;
  final String? parentId;
  final String postedAt;

//<editor-fold desc="Data Methods">
  const Tweet({
    required this.tweet,
    required this.imageLink,
    required this.tweetId,
    required this.uid,
    required this.likes,
    required this.retweets,
    this.parentId,
    required this.postedAt,
  });


  Tweet copyWith({
    String? tweet,
    String? imageLink,
    String? tweetId,
    String? uid,
    List? likes,
    List? retweets,
    String? parentId,
    String? postedAt,
  }) {
    return Tweet(
      tweet: tweet ?? this.tweet,
      imageLink: imageLink ?? this.imageLink,
      tweetId: tweetId ?? this.tweetId,
      uid: uid ?? this.uid,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      parentId: parentId ?? this.parentId,
      postedAt: postedAt ?? this.postedAt,
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
      'postedAt': this.postedAt,
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
      postedAt: map['postedAt'] as String,
    );
  }

//</editor-fold>
}