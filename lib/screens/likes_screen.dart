import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LikesPage extends StatelessWidget {
  final String postId;

  LikesPage({required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beğenenler'),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .get(), // Belirli postu al
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text('Post bulunamadı.'),
            );
          }

          List<String> likedUserIds =
              snapshot.data!.get('likes').cast<String>().toList();

          return ListView.builder(
            itemCount: likedUserIds.length,
            itemBuilder: (BuildContext context, int index) {
              String userId = likedUserIds[index];
              return FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(userId)
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }

                  if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
                    return SizedBox();
                  }

                  String username = userSnapshot.data!.get('username');
                  String photoUrl = userSnapshot.data!.get('photoUrl');

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(photoUrl),
                    ),
                    title: Text(username),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
