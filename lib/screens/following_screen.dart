import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowingPage extends StatelessWidget {
  final String userID;

  FollowingPage(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takip Ettikleri'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Bir hata oluştu');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final List<String> followingUIDs =
              List<String>.from(snapshot.data!.get('following'));
          final List<Stream<DocumentSnapshot>> followingStreams = [];

          followingUIDs.forEach((followingUID) {
            followingStreams.add(FirebaseFirestore.instance
                .collection('users')
                .doc(followingUID)
                .snapshots());
          });

          return ListView.builder(
            itemCount: followingStreams.length,
            itemBuilder: (BuildContext context, int index) {
              return StreamBuilder(
                stream: followingStreams[index],
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData || snapshot.hasError) {
                    return Text('Bir hata oluştu');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final String username = snapshot.data!.get('username');
                  final String photoUrl = snapshot.data!.get('photoUrl');

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
