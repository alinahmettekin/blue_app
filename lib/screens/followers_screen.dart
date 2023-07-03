import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FollowersPage extends StatelessWidget {
  final String userID;

  FollowersPage(this.userID);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takipçiler'),
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

          final List<String> followerUIDs =
              List<String>.from(snapshot.data!.get('followers'));
          final List<Stream<DocumentSnapshot>> followerStreams = [];

          followerUIDs.forEach((followerUID) {
            followerStreams.add(FirebaseFirestore.instance
                .collection('users')
                .doc(followerUID)
                .snapshots());
          });

          return ListView.builder(
            itemCount: followerStreams.length,
            itemBuilder: (BuildContext context, int index) {
              return StreamBuilder(
                stream: followerStreams[index],
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
