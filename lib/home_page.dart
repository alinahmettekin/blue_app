import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> profileImages = [
    "assets/images/deniz.jpeg",
    "assets/images/futbol.jpeg",
    "assets/images/innova.jpeg",
    "assets/images/innnova.jpeg",
    "assets/images/masa.jpeg",
    "assets/images/setup.jpeg",
    "assets/images/summer.jpeg",
    "assets/images/yazi.jpeg",
    "assets/images/instagram-stroies.png"
  ];
  List<String> posts = [
    "assets/images/deniz.jpeg",
    "assets/images/futbol.jpeg",
    "assets/images/innova.jpeg",
    "assets/images/innnova.jpeg",
    "assets/images/masa.jpeg",
    "assets/images/setup.jpeg",
    "assets/images/summer.jpeg",
    "assets/images/yazi.jpeg",
  ];
  Future<void> onRefresh() async {
    await Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Image.asset(
            "assets/images/yazi.jpeg",
            height: 200,
            width: 150,
          ),
          actions: [
            IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () {}),
            IconButton(icon: Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: Icon(Icons.chat_bubble_outline), onPressed: () {}),
          ]),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Story
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    8,
                    (index) => Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              "assets/images/instagram-stories.png",
                            ),
                            child: CircleAvatar(
                              radius: 32,
                              backgroundImage: AssetImage(
                                profileImages[index],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Profile Name",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Divider(),
              // here
              Column(
                children: List.generate(
                  8,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Header Post
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundImage: AssetImage(
                                  "assets/images/instagram-stories.png"),
                              child: CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(
                                  profileImages[index],
                                ),
                              ),
                            ),
                          ),
                          Text("Profile Name "),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      //Image Post
                      Image.asset(posts[index]),

                      //Footer Post
                      Row(children: [
                        IconButton(
                          icon: Icon(Icons.favorite_border,
                              color: Colors.black87),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.chat_bubble_outline,
                              color: Colors.black87),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon:
                              Icon(Icons.label_outline, color: Colors.black87),
                          onPressed: () {},
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            Icons.bookmark_border,
                            color: Colors.black87,
                          ),
                          onPressed: () {},
                        ),
                      ]),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(text: "Liked by"),
                                    TextSpan(
                                      text: "Profile Name ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(text: "and"),
                                    TextSpan(
                                      text: "Profile Name ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: "Profile Name ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "This is the most amazing picture ever put on Instagram.This is also best course ever made :)  ",
                                    ),
                                  ],
                                ),
                              ),
                              Text("View all 12 comments",
                                  style: TextStyle(color: Colors.black38)),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
