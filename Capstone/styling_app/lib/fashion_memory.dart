import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Camera extends StatefulWidget {
  final DateTime param;
  Camera({required this.param});

  @override
  State<Camera> createState() => _CameraState();
}

ScrollController scrollController = ScrollController();

class _CameraState extends State<Camera> {
  final picker = ImagePicker();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<String> imageUrls = [];
  XFile? image; // 카메라로 촬영한 이미지를 저장할 변수
  List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수
  late PageController _pageController;
  late DateTime currentDate;
  final int initialPageOffset = 500;
  bool _isLoading1 = true;
  @override
  void initState() {
    super.initState();
    currentDate = widget.param;
    _pageController = PageController(initialPage: initialPageOffset);
    loadImagesFromStorage(currentDate);
  }

  Future<void> loadImagesFromStorage(DateTime date) async {
    setState(() {
      imageUrls.clear();
      _isLoading1 = true;
    });

    String dateFormatted = DateFormat('MMdd').format(date);

    try {
      ListResult result = await FirebaseStorage.instance
          .ref("$uid/fashion_diary/$dateFormatted")
          .listAll();

      for (final imageRef in result.items) {
        String imageUrl = await imageRef.getDownloadURL();
        setState(() {
          imageUrls.add(imageUrl);
        });
      }
      setState(() {
        _isLoading1 = false;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> addImageToStorage(XFile? file, String dateFormatted) async {
    if (file != null) {
      File imageFile = File(file.path);

      await FirebaseStorage.instance
          .ref("$uid/fashion_diary/$dateFormatted/ootd.jpg")
          .putFile(imageFile);
      await loadImagesFromStorage(currentDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemBuilder: (context, index) {
        DateTime pageDate =
            widget.param.add(Duration(days: index - initialPageOffset));
        return buildPage(pageDate);
      },
      onPageChanged: (index) {
        DateTime newDate =
            widget.param.add(Duration(days: index - initialPageOffset));
        setState(() {
          currentDate = newDate;
        });
        loadImagesFromStorage(newDate);
      },
    );
  }

  Widget buildPage(DateTime pageDate) {
    String dateFormatted = DateFormat('MMdd').format(pageDate);
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return AlertDialog(
      title: Row(
        children: [
          Text(
            DateFormat('M').format(pageDate),
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30,
            ),
          ),
          Text(
            '월 ',
            style: TextStyle(fontFamily: 'Jua', fontSize: 20),
          ),
          Text(
            DateFormat('dd').format(pageDate),
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30,
            ),
          ),
          Text(
            '일 ',
            style: TextStyle(fontFamily: 'Jua', fontSize: 20),
          ),
          Text(
            'OOTD',
            style: TextStyle(
              fontFamily: 'Jua',
              fontSize: 30,
            ),
          ),
        ],
      ),
      content: Container(
        height: screenHeight * 0.45,
        width: screenWidth * 0.9,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical, // 세로 스크롤 방향으로 설정
          child: Column(
            children: [
              _isLoading1
                  ? Center(
                      child: SpinKitFadingCircle(
                        color: Colors.grey, // 색상 설정
                        size: 27.0, // 크기 설정
                        duration: Duration(seconds: 1), //속도 설정
                      ),
                    )
                  : Column(children: [
                      if (imageUrls.isNotEmpty)
                        // 이미지가 있을 때만 로딩
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0,
                          ),
                          itemCount: imageUrls.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              imageUrls[index],
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                    ]),
              Row(
                children: [
                  // 카메라 촬영
                  IconButton(
                    onPressed: () async {
                      image = await picker.pickImage(
                        source: ImageSource.camera,
                      );
                      setState(() {
                        images.clear();
                      });
                      await addImageToStorage(image, dateFormatted);
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  // 갤러리에서 사진 불러오기
                  IconButton(
                    onPressed: () async {
                      multiImage = await picker.pickMultiImage();
                      if (multiImage.isNotEmpty) {
                        setState(() {
                          images.clear();
                          images.addAll(multiImage);
                        });
                        await addImageToStorage(multiImage[0], dateFormatted);
                      }
                    },
                    icon: Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context); // 일단 뒤로가는 걸로 구현
          },
          child: Text(
            '확인',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Jua',
              fontSize: 17,
            ),
          ),
        ),
      ],
    );
  }
}
