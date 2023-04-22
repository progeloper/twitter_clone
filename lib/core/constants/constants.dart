import 'package:flutter/material.dart';
import 'package:twitter_clone/core/common/widgets/tweet_card.dart';
import 'package:twitter_clone/features/auth/screens/login_screen.dart';
import 'package:twitter_clone/features/tweets/screens/create_tweet.dart';
import 'package:twitter_clone/models/tweet.dart';

class Constants{
  static String defaultAvatar = 'https://media.idownloadblog.com/wp-content/uploads/2017/03/Twitter-new-2017-avatar-001.png';
  static String defaultBanner = 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/WikiAfrica_twitter_banner_celebrating_20_years_of_Wikipedia.gif/800px-WikiAfrica_twitter_banner_celebrating_20_years_of_Wikipedia.gif?20210202075323';
  static const spaceBox10 = SizedBox(
    height: 10,
  );
  static const spaceBox20 = SizedBox(
    height: 20,
  );
  static const spaceBox30 = SizedBox(
    height: 30,
  );
  static const spaceBox50 = SizedBox(
    height: 50,
  );

  static const tabScreens = <Widget>[
    Center(child: TweetCard(tweet: Tweet(tweet: 'tweet', tweetId: 'ftvgvtg', uid: 'frvvgtr', likes: [], retweets: [], isThread: false, postedAt: '23 April 2023'),),),
    Center(child: Text('feed'),),
    Center(child: Text('search'),),
    Center(child: Text('notifications'),),
    Center(child: Text('messages'),),
  ];
}