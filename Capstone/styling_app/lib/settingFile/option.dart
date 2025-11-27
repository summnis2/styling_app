import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'bell.dart';
import '../login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Option extends StatelessWidget {
  const Option({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text("환경설정",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 53, 53, 53),
                fontSize: 21)),
        toolbarHeight: 60.0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.grey,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: Container(
          child: Column(
        children: [
          Center(
            child: TextButton(
                onPressed: () {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            '로그아웃',
                          ),
                          content: const Text(
                            '로그아웃 하시겠습니까?',
                          ),
                          actions: <Widget>[
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('취소'),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle:
                                    Theme.of(context).textTheme.labelLarge,
                              ),
                              child: const Text('확인'),
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/', (_) => false);

                                Navigator.of(context).pushNamed("/");
                              },
                            ),
                          ],
                        );
                      });
                },
                child: Text(
                  "로그아웃",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
          ),
        ],
      )),
    );
  }
}
