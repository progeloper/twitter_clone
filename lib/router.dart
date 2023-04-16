import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/features/auth/screens/details_screen.dart';
import 'package:twitter_clone/features/auth/screens/login_screen.dart';
import 'package:twitter_clone/features/auth/screens/signup_screen.dart';

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
