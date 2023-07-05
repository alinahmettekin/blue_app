import 'package:flutter/material.dart';
import 'package:flutter_application/resources/firestore_methods.dart';
import 'package:flutter_application/screens/update_profilepic_screen.dart';
import 'package:flutter_application/utils/colors.dart';
import 'package:flutter_application/widgets/follow_button.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../utils/utils.dart';
import '../widgets/text_field_input.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  bool isLoading = false;

  void updateProfile(String uid, String beforeUserName) async {
    try {
      String res = await FirestoreMethods().updateProfile(
        uid,
        _usernameController.text,
        _bioController.text,
        beforeUserName,
      );

      if (res != 'success') {
        if (context.mounted) {
          showSnackBar(context as String, res as BuildContext);
        }
      }
      setState(() {
        _usernameController.text = "";
        _bioController.text = "";
      });
    } catch (err) {
      showSnackBar(
        "Başarıyla Güncellendi",
        err.toString() as BuildContext,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _bioController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;
    final String beforeUserName = user.username;
    final String currentProfPic = user.photoUrl;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Profili Düzenle"),
        backgroundColor: const Color.fromARGB(255, 112, 99, 99),
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                currentProfPic,
              ),
              radius: 40,
            ),
            const SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    top: 2,
                  ),
                  child: Text("${user.username}"),
                ),
                const SizedBox(
                  height: 24,
                ),
                FollowButton(
                  text: 'Profil resmini güncelle',
                  backgroundColor: mobileBackgroundColor,
                  textColor: primaryColor,
                  borderColor: Color.fromARGB(255, 56, 55, 55),
                  function: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UpdateProfilePicScreen(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Yeni kullanıcı adı girin',
              textInputType: TextInputType.text,
              textEditingController: _usernameController,
            ),
            const SizedBox(
              height: 24,
            ),
            TextFieldInput(
              hintText: 'Yeni hakkında kısmı girin',
              textInputType: TextInputType.text,
              textEditingController: _bioController,
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
                onPressed: () => updateProfile(
                      user.uid,
                      beforeUserName,
                    ),
                child: const Text("Kaydet")),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
