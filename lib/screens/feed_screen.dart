import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:flutter_application/utils/global_variables.dart';
import 'package:flutter_application/widgets/post_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: Color.fromARGB(255, 56, 55, 55),
              centerTitle: true,
              toolbarHeight: 50,
              title: SvgPicture.asset(
                'assets/blue-removebg-preview.svg',
                color: Colors.white,
                height: 50,
              ),
              actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.messenger_outline,
                      color: primaryColor,
                    ),
                    onPressed: () {},
                  )
                ]),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: Text("Yükleniyor..."),
              );
            }
            final data = snapshot.data!;

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: width > webScreenSize ? width * 0.3 : 0,
                        vertical: width > webScreenSize ? 15 : 0,
                      ),
                      child: PostCard(
                        snap: snapshot.data!.docs[index].data(),
                      ),
                    ));
          }),
    );
  }
}
