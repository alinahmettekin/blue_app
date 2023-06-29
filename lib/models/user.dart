import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String uid;
  final String photoUrl;
  final String username;
  final String bio;
  final List followers;
  final List following;

  const User(
      {required this.username,
      required this.uid,
      required this.photoUrl,
      required this.email,
      required this.bio,
      required this.followers,
      required this.following});

  static User fromSnapshot(DocumentSnapshot snapshot) {
    if (snapshot != null) {
      var data = snapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return User(
          username: data["username"],
          uid: data["uid"],
          email: data["email"],
          photoUrl: data["photoUrl"],
          bio: data["bio"],
          followers: data["followers"],
          following: data["following"],
        );
      }
    }

    throw Exception('Snapshot data is null');
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
        "photoUrl": photoUrl,
        "bio": bio,
        "followers": followers,
        "following": following,
      };
}
