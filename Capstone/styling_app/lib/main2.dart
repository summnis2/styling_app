import 'package:flutter/material.dart';
import 'settingFile/option.dart';
import '../closet.dart';
import '../save.dart';

ScrollController scrollController = ScrollController();

class MyCloset extends StatelessWidget {
  const MyCloset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 2000, //스크롤을 위한 박스사이즈 지정 (숫자 작게 하면 화면에 달력 다 안 담겨요.)
            child: Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Color.fromARGB(255, 250, 250, 250),
                title: Text("나의 옷장",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 53, 53, 53),
                        fontSize: 25)),
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                actions: [],
              ),
              body: Container(
                  margin: EdgeInsets.all(20),
                  color: Color.fromARGB(255, 250, 250, 250),
//          mainAxisAlignment: MainAxisAlignment.spaceEvenly, //중간정렬
//          crossAxisAlignment: CrossAxisAlignment.center, //반대축정렬?
                  child: Column(children: [
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //TOP
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Option()))
                                },
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: Color.fromARGB(255, 85, 85, 85)),
                              const Text("  상의",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  TOP",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //BOTTOM
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Closet()),
                                  ),
                                },
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  하의",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  PANTS/SKIRT",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //OUTER
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Save()))
                                },
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  아우터",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  OUTER",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //DRESS
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {},
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  원피스",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  DRESS",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //shoes
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {},
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  신발",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  SHOES",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //bag
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {},
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  가방",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  BAG",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                    Divider(color: const Color.fromARGB(255, 128, 128, 128)),
                    Center(
                        //ACCESSORY
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: Size(200, 50)),
                            onPressed: () => {},
                            child: Row(children: [
                              Icon(Icons.add,
                                  color: const Color.fromARGB(255, 85, 85, 85)),
                              const Text("  패션소품",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 53, 53, 53),
                                  )),
                              Text("  ACCESSORY",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: const Color.fromARGB(
                                        255, 124, 124, 124),
                                  ))
                            ]))),
                  ])),
              bottomNavigationBar: BottomAppBar(
                elevation: 0.0,
                child: Container(
                  color: Color.fromARGB(255, 250, 250, 250),
                  height: 50.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
