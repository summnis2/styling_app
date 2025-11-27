import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          title: Text("내 정보 보기",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 53, 53, 53),
                  fontSize: 25)),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.grey,
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            color: Color.fromARGB(255, 250, 250, 250),
            child: Column(children: [
              Divider(color: const Color.fromARGB(255, 128, 128, 128)),
              Center(
                  child: Row(children: [
                const Text("  닉네임",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
            ])));
  }
}
