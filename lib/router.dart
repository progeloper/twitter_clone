import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/features/auth/screens/details_screen.dart';
import 'package:twitter_clone/features/auth/screens/login_screen.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen.dart';
import 'package:twitter_clone/features/home/screens/home_screen.dart';
import 'package:twitter_clone/features/home/screens/settings_screen.dart';
import 'package:twitter_clone/features/profiles/screens/edit_profile_screen.dart';
import 'package:twitter_clone/features/profiles/screens/profile_screen.dart';
import 'package:twitter_clone/features/tweets/screens/create_comment_screen.dart';
import 'package:twitter_clone/features/tweets/screens/create_tweet_screen.dart';
import 'package:twitter_clone/features/tweets/screens/tweet_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
  '/signup-screen': (_) => const MaterialPage(child: SignUpScreen()),
  '/details-screen/:name/:email/:dob': (route) => MaterialPage(
          child: DetailsScreen(
        name: route.pathParameters['name']!,
        email: route.pathParameters['email']!,
        dob: route.pathParameters['dob']!,
      )),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/profile-screen/:uid': (route) => MaterialPage(child: ProfileScreen(uid: route.pathParameters['uid']!)),
  '/settings-screen' : (route) => const MaterialPage(child: SettingsScreen()),
  '/create-tweet-screen': (_) => const MaterialPage(child: CreateTweetScreen()),
  '/create-comment-screen/:tweetId': (route) => MaterialPage(child: CreateCommentScreen(tweetId: route.pathParameters['tweetId']!)),
  '/tweet-screen/:tweetId' : (route) => MaterialPage(child: TweetScreen(tweetId: route.pathParameters['tweetId']!)),
  '/edit-profile-screen/:uid' : (route) => MaterialPage(child: EditProfileScreen(uid: route.pathParameters['uid']!)),

});
