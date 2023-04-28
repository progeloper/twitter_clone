class Tweet{
  final String tweet;
  final List imageLink;
  final String tweetId;
  final String uid;
  final List likes;
  final List retweets;
  final String postedAt;
  final String profilePic;
  final String username;
  final String name;
  final int commentCount;

//<editor-fold desc="Data Methods">
  const Tweet({
    required this.tweet,
    required this.imageLink,
    required this.tweetId,
    required this.uid,
    required this.likes,
    required this.retweets,
    required this.postedAt,
    required this.profilePic,
    required this.username,
    required this.name,
    required this.commentCount,
  });


  Tweet copyWith({
    String? tweet,
    List? imageLink,
    String? tweetId,
    String? uid,
    List? likes,
    List? retweets,
    String? postedAt,
    String? profilePic,
    String? username,
    String? name,
    int? commentCount,
  }) {
    return Tweet(
      tweet: tweet ?? this.tweet,
      imageLink: imageLink ?? this.imageLink,
      tweetId: tweetId ?? this.tweetId,
      uid: uid ?? this.uid,
      likes: likes ?? this.likes,
      retweets: retweets ?? this.retweets,
      postedAt: postedAt ?? this.postedAt,
      profilePic: profilePic ?? this.profilePic,
      username: username ?? this.username,
      name: name ?? this.name,
      commentCount: commentCount ?? this.commentCount,
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
      'postedAt': this.postedAt,
      'profilePic': this.profilePic,
      'username': this.username,
      'name': this.name,
      'commentCount': this.commentCount,
    };
  }

  factory Tweet.fromMap(Map<String, dynamic> map) {
    return Tweet(
      tweet: map['tweet'] as String,
      imageLink: map['imageLink'] as List,
      tweetId: map['tweetId'] as String,
      uid: map['uid'] as String,
      likes: map['likes'] as List,
      retweets: map['retweets'] as List,
      postedAt: map['postedAt'] as String,
      profilePic: map['profilePic'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      commentCount: map['commentCount'] as int,
    );
  }

//</editor-fold>
}