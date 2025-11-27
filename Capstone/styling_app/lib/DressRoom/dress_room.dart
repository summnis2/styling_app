import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:styling_app/DressRoom/add_dress.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:styling_app/DressRoom/dropbox.dart';
import 'package:styling_app/fashion_memory.dart';
import '../DressRoom/take_picture.dart';

class DressRoom extends StatefulWidget {
  const DressRoom({super.key});

  @override
  State<DressRoom> createState() => _DressRoomState();
}

ScrollController scrollController = ScrollController();
bool _isLoading1 = false;
bool _isLoading2 = false;
bool _isLoading3 = false;
bool _isLoading4 = false;
bool _isLoading5 = false;
bool _isLoading6 = false;
bool _isLoading7 = false;
List<bool> _isLoading = [false, false, false, false, false, false, false];

class _DressRoomState extends State<DressRoom> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  List<Map<String, dynamic>> imageUrls = []; // 아우터
  List<Map<String, dynamic>> imageUrls2 = []; // 상의
  List<Map<String, dynamic>> imageUrls3 = []; // 하의
  List<Map<String, dynamic>> imageUrls4 = []; // 신발
  List<Map<String, dynamic>> imageUrls5 = []; // 원피스
  List<Map<String, dynamic>> imageUrls6 = []; // 가방
  List<Map<String, dynamic>> imageUrls7 = []; // 패션소품

  @override
  void initState() {
    super.initState();
    loadData1();
    loadData2();
    loadData3();
    loadData4();
    loadData5();
    loadData6();
    loadData7();
  }

  Future<void> loadData1() async {
    setState(() {
      _isLoading[0] = true;
    });
    await loadImageUrls();
    setState(() {
      _isLoading[0] = false;
    });
  }

  Future<void> loadData2() async {
    setState(() {
      _isLoading[1] = true;
    });
    await loadImageUrls2();
    setState(() {
      _isLoading[1] = false;
    });
  }

  Future<void> loadData3() async {
    setState(() {
      _isLoading[2] = true;
    });
    await loadImageUrls3();
    setState(() {
      _isLoading[2] = false;
    });
  }

  Future<void> loadData4() async {
    setState(() {
      _isLoading[3] = true;
    });
    await loadImageUrls4();
    setState(() {
      _isLoading[3] = false;
    });
  }

  Future<void> loadData5() async {
    setState(() {
      _isLoading[4] = true;
    });
    await loadImageUrls5();
    setState(() {
      _isLoading[4] = false;
    });
  }

  Future<void> loadData6() async {
    setState(() {
      _isLoading[5] = true;
    });
    await loadImageUrls6();
    setState(() {
      _isLoading[5] = false;
    });
  }

  Future<void> loadData7() async {
    setState(() {
      _isLoading[6] = true;
    });
    await loadImageUrls7();
    setState(() {
      _isLoading[6] = false;
    });
  }

  Future<void> loadImageUrls() async {
    // 아우터 불러오기
    try {
      ListResult result = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/아우터")
          .listAll();

      List<Map<String, dynamic>> tempUrls = [];
      for (final imageRef in result.items) {
        String imageUrl = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls.add({'url': imageUrl, 'time': metadata.timeCreated});
      }
      tempUrls.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls = tempUrls;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls2() async {
    // 상의 불러오기
    try {
      ListResult result2 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/상의")
          .listAll();

      List<Map<String, dynamic>> tempUrls2 = [];
      for (final imageRef in result2.items) {
        String imageUrl2 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls2.add({'url': imageUrl2, 'time': metadata.timeCreated});
      }
      tempUrls2.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls2 = tempUrls2;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls3() async {
    // 하의 불러오기
    try {
      ListResult result3 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/하의")
          .listAll();

      List<Map<String, dynamic>> tempUrls3 = [];
      for (final imageRef in result3.items) {
        String imageUrl3 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls3.add({'url': imageUrl3, 'time': metadata.timeCreated});
      }
      tempUrls3.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls3 = tempUrls3;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls4() async {
    // 신발 불러오기
    try {
      ListResult result4 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/신발")
          .listAll();

      List<Map<String, dynamic>> tempUrls4 = [];
      for (final imageRef in result4.items) {
        String imageUrl4 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls4.add({'url': imageUrl4, 'time': metadata.timeCreated});
      }
      tempUrls4.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls4 = tempUrls4;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls5() async {
    // 원피스 불러오기
    try {
      ListResult result5 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/원피스")
          .listAll();

      List<Map<String, dynamic>> tempUrls5 = [];
      for (final imageRef in result5.items) {
        String imageUrl5 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls5.add({'url': imageUrl5, 'time': metadata.timeCreated});
      }
      tempUrls5.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls5 = tempUrls5;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls6() async {
    // 가방 불러오기
    try {
      ListResult result6 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/가방")
          .listAll();

      List<Map<String, dynamic>> tempUrls6 = [];
      for (final imageRef in result6.items) {
        String imageUrl6 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls6.add({'url': imageUrl6, 'time': metadata.timeCreated});
      }
      tempUrls6.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls6 = tempUrls6;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  Future<void> loadImageUrls7() async {
    // 패션소품 불러오기
    try {
      ListResult result7 = await FirebaseStorage.instance
          .ref("$uid/clothes_sample/women/패션소품")
          .listAll();

      List<Map<String, dynamic>> tempUrls7 = [];
      for (final imageRef in result7.items) {
        String imageUrl7 = await imageRef.getDownloadURL();
        FullMetadata metadata = await imageRef.getMetadata();
        tempUrls7.add({'url': imageUrl7, 'time': metadata.timeCreated});
      }
      tempUrls7.sort((a, b) => b['time'].compareTo(a['time']));
      setState(() {
        imageUrls7 = tempUrls7;
      });
    } catch (e) {
      print('Error loading images: $e');
    }
  }

  void openCategoryDetail(
      String category, List<Map<String, dynamic>> imageUrls) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryDetail(
                category: category,
                imageUrls: imageUrls,
                onFavoriteToggle: (String imageUrl) {
                  FirebaseFirestore.instance
                      .collection('like')
                      .doc()
                      .set({'uid': uid, 'url': imageUrl, 'category': category});
                  print('Added to favorites: $imageUrl');
                },
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/closet.png',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                backgroundColor: Colors.white,
                context: context,
                builder: (context) {
                  return TakePicture();
                },
              );
            },
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            loadData1();
            loadData2();
            loadData3();
            loadData4();
            loadData5();
            loadData6();
            loadData7();
          });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              categoryWidget('아우터', imageUrls, screenHeight, screenWidth, 0),
              categoryWidget('상의', imageUrls2, screenHeight, screenWidth, 1),
              categoryWidget('하의', imageUrls3, screenHeight, screenWidth, 2),
              categoryWidget('신발', imageUrls4, screenHeight, screenWidth, 3),
              categoryWidget('원피스', imageUrls5, screenHeight, screenWidth, 4),
              categoryWidget('가방', imageUrls6, screenHeight, screenWidth, 5),
              categoryWidget('패션소품', imageUrls7, screenHeight, screenWidth, 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget categoryWidget(String category, List<Map<String, dynamic>> imageUrls,
      double screenHeight, double screenWidth, index) {
    return Container(
      margin:
          EdgeInsets.only(left: screenWidth * 0.03, top: screenHeight * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                category,
                style: TextStyle(
                  fontSize: screenWidth * 0.06,
                  fontFamily: 'Jua',
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              IconButton(
                onPressed: () => openCategoryDetail(category, imageUrls),
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          _isLoading[index]
              ? Container(
                  height: screenHeight * 0.2,
                  child: Center(
                    child: SpinKitThreeBounce(
                      color: const Color.fromARGB(255, 83, 83, 83), // 색상 설정
                      size: 30.0, // 크기 설정
                      duration: Duration(seconds: 2), //속도 설정
                    ),
                  ))
              : Container(
                  height: screenHeight * 0.2,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrls.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => openCategoryDetail(category, imageUrls),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.01),
                          child: Image.network(imageUrls[index]['url']),
                        ),
                      );
                    },
                  ),
                ),
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              height: 0.3,
            ),
          )
        ],
      ),
    );
  }
}

class CategoryDetail extends StatefulWidget {
  final String category;
  final List<Map<String, dynamic>> imageUrls;
  final Function(String) onFavoriteToggle;

  const CategoryDetail({
    Key? key,
    required this.category,
    required this.imageUrls,
    required this.onFavoriteToggle,
  }) : super(key: key);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<Map<String, dynamic>> sortedImageUrls = [];
  String sortOption = '최신순';
  Map<String, bool> favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    sortImages();
  }

  Future<void> sortImages() async {
    List<String> likedImageUrls = await loadLikedImageUrls(widget.category);

    setState(() {
      sortedImageUrls = List.from(widget.imageUrls);

      if (sortOption == '최신순') {
        sortedImageUrls.sort((a, b) => b['time'].compareTo(a['time']));
      } else if (sortOption == '오래된순') {
        sortedImageUrls.sort((a, b) => a['time'].compareTo(b['time']));
      } else if (sortOption == 'LIKE') {
        sortedImageUrls = sortedImageUrls
            .where((image) => likedImageUrls.contains(image['url']))
            .toList();
      }

      for (var imageMap in sortedImageUrls) {
        String imageUrl = imageMap['url'];
        favoriteStatus[imageUrl] = likedImageUrls.contains(imageUrl);
      }
    });
  }

  Future<List<String>> loadLikedImageUrls(String category) async {
    List<String> likedImageUrls = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('like')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('category', isEqualTo: category)
        .get();

    likedImageUrls =
        querySnapshot.docs.map((doc) => doc['url'] as String).toList();

    return likedImageUrls;
  }

  void toggleFavorite(String imageUrl) {
    setState(() {
      favoriteStatus[imageUrl] = !favoriteStatus[imageUrl]!;
    });

    if (favoriteStatus[imageUrl]!) {
      addLike(imageUrl, widget.category);
    } else {
      removeLike(imageUrl);
    }
  }

  void addLike(String imageUrl, String category) {
    FirebaseFirestore.instance.collection('like').add({
      'uid': FirebaseAuth.instance.currentUser!.uid,
      'url': imageUrl,
      'category': category,
    });
  }

  void removeLike(String imageUrl) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('like')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('url', isEqualTo: imageUrl)
        .get();

    for (var doc in querySnapshot.docs) {
      await doc.reference.delete();
    }

    if (sortOption == 'LIKE') {
      setState(() {
        sortedImageUrls.removeWhere((image) => image['url'] == imageUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 80.0,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black), // 원하는 색상으로 변경
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.category,
          style: TextStyle(
              fontSize: screenWidth * 0.06,
              fontFamily: 'Jua',
              color: Colors.black),
        ),
        actions: [
          Row(children: [
            DropdownButton<String>(
              value: sortOption,
              style: TextStyle(
                fontSize: screenWidth * 0.045, // 폰트 크기 조절
                fontFamily: 'Jua', // 폰트 변경
                color: Colors.black54, // 텍스트 색상 변경
              ),
              //iconSize: 25,
              icon: Padding(
                padding: const EdgeInsets.only(right: 8.0), // 오른쪽에 공백을 주는 패딩 설정
                child: Icon(
                  Icons.arrow_drop_down, // 드롭다운 아이콘
                  color: Colors.black, // 아이콘 색상
                ),
              ),
              // 드롭다운 메뉴 아이템 설정
              items: <String>['최신순', '오래된순', 'LIKE']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  sortOption = newValue!;
                  sortImages();
                });
              },
              underline: Container(), // 아래선 없애기
            ),
          ])
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemCount: sortedImageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          String imageUrl = sortedImageUrls[index]['url'];
          bool isFavorite = favoriteStatus[imageUrl] ?? false;
          return GestureDetector(
            onTap: () {
              toggleFavorite(imageUrl);
            },
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
