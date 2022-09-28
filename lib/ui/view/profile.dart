import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quizu/core/constances/decorations.dart';
import 'package:quizu/core/models/score.dart';
import 'package:quizu/core/providers/userProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

List<String> list;

class _ProfileViewState extends State<ProfileView> {
  Future pickImage(BuildContext context) async {
    final localStorage = await SharedPreferences.getInstance();
    try {
      final selectedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (selectedImage == null) {
        return;
      } else {
        final imageTemp = selectedImage.path;
        localStorage.setString('image', imageTemp);
        // Provider.of<AuthProvider>(context, listen: false).updateUserImage(imageTemp);
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  void setState(VoidCallback fn) async {
    // final localStorage = await SharedPreferences.getInstance();
    // List<String> list = localStorage.getStringList('Score');
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context);
    final user = Provider.of<UserProvider>(context);
    List<String> nameList;
    List<String> timeList;
    // final userScores = Provider.of<ScoresProvider>(context).getUserScores;

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SizedBox(
          width: screenSize.size.width,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                // ignore: void_checks
                onPressed: () async {
                  final localStorage = await SharedPreferences.getInstance();

                  localStorage.clear();
                  user.logout();
                  return Navigator.pushNamedAndRemoveUntil(context, '/LoginView', (route) => false);
                },
                icon: Icon(Icons.logout),
                color: Colors.red,
              ),
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () => pickImage(context),
                  child: Container(
                    height: screenSize.size.height * 0.06,
                    width: screenSize.size.height * 0.06,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: kPrimaryColor,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/ResetNameView');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.userName,
                    style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              user.userPhone,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                ),
                child: FutureBuilder<SharedPreferences>(
                  future: SharedPreferences.getInstance(),
                  builder: (context, localStorage) {
                    List<String> scores = localStorage.data.getStringList('Scores');
                    if (scores != null) {
                      int extraindex = -2;
                      nameList = [];
                      timeList = [];
                      for (var i = 0; i < scores.length ~/ 2; i++) {
                        extraindex += 2;
                        timeList.add(scores[extraindex]);
                        nameList.add(scores[extraindex + 1]);
                      }
                      timeList.sort(
                        (b, a) {
                          //sorting order
                          return DateTime.parse(b).compareTo(DateTime.parse(a));
                        },
                      );

                      extraindex = -2;
                      return ListView.builder(
                        itemCount: timeList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                            color: Colors.white,
                            child: ListTile(
                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32))),
                              leading: Text((index + 1).toString()),
                              title: Text(timeList[index]),
                              trailing: Text(
                                nameList[index],
                              ),
                            ),
                          );
                          ;
                        },
                      );
                    } else {
                      return Lottie.asset('assets/animations/no-data-error.json');
                    }
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
