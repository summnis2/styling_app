import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:styling_app/DressRoom/dropbox.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:firebase_database/firebase_database.dart';
import '../DressRoom/dress_room.dart';
import '../bottom.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

ScrollController scrollController = ScrollController();

class AddDress extends StatefulWidget {
  final XFile image;
  final String rbg;
  AddDress({required this.image, required this.rbg});

  @override
  State<AddDress> createState() => _AddDressState();
}

class _AddDressState extends State<AddDress> {
  Color currentColor = Colors.transparent;
  String? colorHEX;

  @override
  void initState() {
    super.initState();
    currentColor = parseRgbToColor(widget.rbg);
  }

  String rgbToHex(int c) {
    List<String> hex = [];
    hex.add((c / 16).toStringAsFixed(0));
    hex.add((c % 16).toStringAsFixed(0));

    for (int i = 0; i < hex.length; i++) {
      if (hex[i] == '10')
        hex[i] = 'A';
      else if (hex[i] == '11')
        hex[i] = 'B';
      else if (hex[i] == '12')
        hex[i] = 'C';
      else if (hex[i] == '13')
        hex[i] = 'D';
      else if (hex[i] == '14')
        hex[i] = 'E';
      else if (hex[i] == '15') hex[i] = 'F';
    }
    String hexCode = hex[0] + hex[1];
    return hexCode;
  }

  Color parseRgbToColor(String rgbString) {
    List<String> parts = rgbString.split(',').map((s) => s.trim()).toList();
    if (parts.length != 3) return Colors.transparent; // 잘못된 포맷 처리

    int red = int.parse(parts[0]);
    int green = int.parse(parts[1]);
    int blue = int.parse(parts[2]);

    // 0과 255 사이의 값으로 조정
    red = (red < 0 ? 0 : (red > 255 ? 255 : red));
    green = (green < 0 ? 0 : (green > 255 ? 255 : green));
    blue = (blue < 0 ? 0 : (blue > 255 ? 255 : blue));

    colorHEX = '#' + rgbToHex(red) + rgbToHex(green) + rgbToHex(blue);
    print((red / 16).toStringAsFixed(0));
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  String dressType1 = ''; // 수정: dressType 변수 추가
  String dressType2 = ''; // 수정: dressType 변수 추가
  String style = ''; // 수정: style 변수 추가
  String colors = '';

  DatabaseReference _dressRef = FirebaseDatabase.instance.reference();
  Future<String?> _uploadImageToFirebase(XFile? image) async {
    if (image == null) return null;
    try {
      String fileName = basename(image.path);
      String uid = FirebaseAuth.instance.currentUser!.uid;

      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              '$uid/clothes_sample/women/$dressType1/$fileName'); //의류까지는 데이터 받아옴

      firebase_storage.UploadTask uploadTask = ref.putFile(File(image.path));
      await uploadTask.whenComplete(() => null);
      String downloadURL = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('clothes_details')
          .doc(uid)
          .collection('fileName')
          .doc(fileName)
          .set({
        'fileName': fileName,
        'dressType1': dressType1,
        'dressType2': dressType2,
        'style': style,
        'colors': colorHEX,
        'url': downloadURL,
      });
      return downloadURL;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }

  Future<bool> _addToFirebase(List<String> colors, String? imageUrl) async {
    _dressRef.push().set({
      'type1': dressType1,
      'type2': dressType2,
      'style': style,
      'colors': colors,
      'imageUrl': imageUrl, // 이미지 URL을 Firebase에 저장
    }).then((value) {
      print('Dress added to Firebase');
      // 성공적으로 추가된 경우 여기에 추가로 작업을 수행할 수 있습니다.
    }).catchError((error) {
      print('Failed to add dress: $error');
    });
    return true;
  }

//*********************************************************************************
  @override
  Widget build(BuildContext context) {
    //화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    bool isEnd = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          elevation: 0.0,
          title: Text(
            '옷 추가하기',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 21),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios)),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // 옷 정보를 Firebase에 추가
                List<String> colors = [];

                String? imageUrl = await _uploadImageToFirebase(widget.image);

                _addToFirebase(colors, imageUrl);

                // // Firebase에 추가한 후 _imageFile 초기화 및 페이지 이동
                // setState(() {
                //   widget.image = null;
                // });

                Navigator.pop(context);
              },
              child: Text(
                '완료',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 텍스트 버튼과 다르게 배경색 변경
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 0.0),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 2000,
            child: Center(
              child: Stack(
                children: [
                  Column(
                    children: [
                      //사진============================
                      Container(
                          margin: EdgeInsets.only(top: 11.0),
                          width: 350,
                          height: 200,
                          color: Color.fromARGB(255, 223, 223, 223),
                          child: Image.file(
                            File(widget.image.path),
                          )),
                      //구분선=============================
                      Container(
                        padding: EdgeInsets.only(left: 18.0),
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "의류",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Jua'),
                            ),
                            Expanded(
                                child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 18.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            )),
                          ],
                        ),
                      ),
                      //의류 + 종류 드롭박스===============================
                      Container(
                          child: ClothesDropdown(
                        onItemSelected1: (selectedType) {
                          setState(() {
                            dressType1 = selectedType ?? ''; // 수정: 선택된 옷 종류 저장
                          });
                        },
                        onItemSelected2: (selectedType) {
                          setState(() {
                            dressType2 = selectedType ?? ''; // 수정: 선택된 옷 종류 저장
                          });
                        },
                        onItemSelected3: (selectedType) {
                          setState(() {
                            style = selectedType ?? ''; // 수정: 선택된 옷 종류 저장
                          });
                        },
                      )),
                      //계절============================================

                      ////////////////////////////////////
                      Container(
                        padding: EdgeInsets.only(left: 18.0),
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Text(
                              "색상",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Jua'),
                            ),
                            Expanded(
                                child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 18.0),
                              child: Divider(
                                color: Colors.black,
                                height: 36,
                              ),
                            )),
                          ],
                        ),
                      ),
                      Container(
                          child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: screenWidth * 0.04,
                                top: screenWidth * 0.02,
                                right: screenWidth * 0.03),
                            width: screenWidth * 0.13,
                            height: screenWidth * 0.13,
                            decoration: BoxDecoration(
                              color: currentColor, // 현재 색상을 배경색으로 사용
                              border: Border.all(
                                color: Colors.black, // 테두리 색상
                                width: 2, // 테두리 두께
                              ),
                            ),
                          ),
                          Text(
                            '$colorHEX',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 19,
                                fontFamily: 'Jua'),
                          ),
                        ],
                      )),
                    ],
                  ),
                  Container()
                ],
              ),
            ),
          ),
        ));
  }
}

Widget _loading(context) {
  //화면 가로, 세로 크기
  var screenWidth = MediaQuery.of(context).size.width;
  var screenHeight = MediaQuery.of(context).size.height;
  return Container(
    width: screenWidth,
    height: screenHeight,
    color: Color.fromARGB(59, 203, 203, 203),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitFadingCircle(
            color: Colors.grey, // 색상 설정
            size: 27.0, // 크기 설정
            duration: Duration(seconds: 1), //속도 설정
          ),
        ],
      ),
    ),
  );
}
