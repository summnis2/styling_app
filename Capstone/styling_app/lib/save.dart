import 'package:flutter/material.dart';

class Save extends StatelessWidget {
  const Save({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Color.fromARGB(255, 250, 250, 250),
          title: Text("나의 옷장",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 53, 53, 53),
                  fontSize: 22)),
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
              //Divider(color: const Color.fromARGB(255, 128, 128, 128)),
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
                const Text("  계절",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
              Divider(color: const Color.fromARGB(255, 128, 128, 128)),
              Center(
                  child: Row(children: [
                const Text("  색상",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color.fromARGB(255, 53, 53, 53),
                    )),
              ])),
            ])));
  }
}
