import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class addPhoto extends StatelessWidget {
  const addPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('옷 추가하기'),
          onPressed: () {
            Navigator.pop(context); //일단 뒤로가는 걸로 구현
          },
        ),
      ),
    );
  }
}
