import 'package:flutter/material.dart';
import 'package:flutter_application/screens/add_post_screen.dart';
import 'package:flutter_application/screens/profile_screen.dart';
import 'package:flutter_application/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  SearchScreen(),
  const AddPostScreen(),
  const Text('notifications'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
];
