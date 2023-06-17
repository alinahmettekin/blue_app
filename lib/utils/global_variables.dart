import 'package:flutter/material.dart';
import 'package:flutter_application/screens/add_post_screen.dart';

import '../screens/feed_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const AddPostScreen(),
  const Text('notifications'),
];
