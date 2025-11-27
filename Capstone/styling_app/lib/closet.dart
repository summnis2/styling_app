import 'package:flutter/material.dart';

class Closet extends StatelessWidget {
  const Closet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          title: Text("나의 옷장",
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
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(20, 30),
                    elevation: 0.0,
                    backgroundColor: const Color.fromARGB(255, 82, 82, 82)),
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(Icons.add, color: Color.fromARGB(255, 255, 255, 255)),
                    const Text("  추가"),
                  ],
                )),
          ],
        ),
        body: Container(
            margin: EdgeInsets.all(20),
            color: Color.fromARGB(255, 250, 250, 250),
            child: Column(children: [
              Divider(color: const Color.fromARGB(255, 128, 128, 128)),
              Center(
                  child: Row(children: [
                const Text("  상의",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
              Column(
                children: [Image.asset("images/glass.ipg")],
              ),
              Divider(color: const Color.fromARGB(255, 128, 128, 128)),
              Center(
                  child: Row(children: [
                const Text("  하의",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
              Column(
                children: [Image.asset("images/glass.ipg")],
              ),
              Divider(color: const Color.fromARGB(255, 128, 128, 128)),
              Center(
                  child: Row(children: [
                const Text("  아우터",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
              Column(
                children: [Image.asset("images/glass.ipg")],
              ),
            ])));
  }
}
