import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Recommand extends StatefulWidget {
  final param;
  final param2;
  Recommand({super.key, required this.param, required this.param2});

  @override
  State<Recommand> createState() => _RecommandState();
}

ScrollController scrollController = ScrollController();

class _RecommandState extends State<Recommand> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? selectedTopUrl;
  String? selectedOuterUrl;
  String? selectedBottomUrl;
  List<String> outerUrls = [];
  List<String> bottomUrls = [];
  List<Color> outerColors = [];
  List<Color> bottomColors = [];
  var temp_topColor;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    await loadImageUrls();
    await getPalette();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> loadImageUrls() async {
    var temp = widget.param;
    var style = widget.param2;

    try {
      QuerySnapshot? outerQuerySnapshot;
      QuerySnapshot? topQuerySnapshot;
      QuerySnapshot? bottomQuerySnapshot;

      if (temp <= 4) {
        outerQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['패딩', '코트'])
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '기모바지')
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 8) {
        outerQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '코트')
            .where('style', isEqualTo: style)
            .get();

        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '니트')
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['기모바지', '레깅스'])
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 11) {
        outerQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['코트', '야상', '자켓'])
            .where('style', isEqualTo: style)
            .get();

        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '니트')
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '데님')
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 16) {
        outerQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['자켓', '가디건', '야상'])
            .where('style', isEqualTo: style)
            .get();

        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '후드티')
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '데님')
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 19) {
        outerQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '가디건')
            .where('style', isEqualTo: style)
            .get();

        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '맨투맨')
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '데님')
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 22) {
        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['블라우스', '셔츠', '조끼'])
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: ['데님', '롱팬츠'])
            .where('style', isEqualTo: style)
            .get();
      } else if (temp <= 27) {
        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '반팔티')
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '숏팬츠')
            .where('style', isEqualTo: style)
            .get();
      } else {
        topQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', whereIn: ['반팔티', '민소매'])
            .where('style', isEqualTo: style)
            .get();

        bottomQuerySnapshot = await FirebaseFirestore.instance
            .collection('clothes_details')
            .doc(uid)
            .collection('fileName')
            .where('dressType2', isEqualTo: '숏팬츠')
            .where('style', isEqualTo: style)
            .get();
      }

      if (topQuerySnapshot != null && topQuerySnapshot.docs.isNotEmpty) {
        List<String> topUrls = _getRandomUrls(topQuerySnapshot.docs, 1);
        if (topUrls.isNotEmpty) {
          selectedTopUrl = topUrls.first;
        }
      }

      if (outerQuerySnapshot != null && outerQuerySnapshot.docs.isNotEmpty) {
        outerUrls = _getRandomUrls(outerQuerySnapshot.docs, 10);
        for (int i = 0; i < outerUrls.length; i++) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('clothes_details')
              .doc(uid)
              .collection('fileName')
              .where('url', isEqualTo: outerUrls[i])
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            var colorString = querySnapshot.docs.first['colors'];
            try {
              outerColors.add(parseColor(colorString));
            } catch (e) {
              print('Invalid color format for outer: $colorString');
            }
          }
        }
      }

      if (bottomQuerySnapshot != null && bottomQuerySnapshot.docs.isNotEmpty) {
        bottomUrls = _getRandomUrls(bottomQuerySnapshot.docs, 10);
        for (int i = 0; i < bottomUrls.length; i++) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('clothes_details')
              .doc(uid)
              .collection('fileName')
              .where('url', isEqualTo: bottomUrls[i])
              .get();
          if (querySnapshot.docs.isNotEmpty) {
            var colorString = querySnapshot.docs.first['colors'];
            try {
              bottomColors.add(parseColor(colorString));
            } catch (e) {
              print('Invalid color format for bottom: $colorString');
            }
          }
        }
      }
    } catch (e) {
      print('Error loading image URLs: $e');
    }
  }

  Future<void> getPalette() async {
    if (selectedTopUrl != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('clothes_details')
          .doc(uid)
          .collection('fileName')
          .where('url', isEqualTo: selectedTopUrl)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var colorString = querySnapshot.docs.first['colors'];
        try {
          temp_topColor = parseColor(colorString);
        } catch (e) {
          print('Error parsing color: $e');
        }
      }
      Color topColor = temp_topColor;

      if (outerUrls.isNotEmpty) {
        selectedOuterUrl =
            findClosestColorUrl(outerUrls, outerColors, topColor);
      }

      if (bottomUrls.isNotEmpty) {
        Color complementaryColor = getComplementaryColor(topColor);
        selectedBottomUrl =
            findClosestColorUrl(bottomUrls, bottomColors, complementaryColor);
      }
    }
  }

  String findClosestColorUrl(
      List<String> urls, List<Color> colors, Color targetColor) {
    double closestDistance = double.infinity;
    String closestUrl = urls.first;

    for (int i = 0; i < colors.length; i++) {
      double distance = calculateColorDistance(colors[i], targetColor);
      if (distance < closestDistance) {
        closestDistance = distance;
        closestUrl = urls[i];
      }
    }

    return closestUrl;
  }

  List<String> _getRandomUrls(List<QueryDocumentSnapshot> docs, int count) {
    docs.shuffle();
    return docs.take(count).map((doc) => doc['url'] as String).toList();
  }

  Color parseColor(String colorString) {
    final validHexPattern = RegExp(r'^#([A-Fa-f0-9]{6})$');
    if (validHexPattern.hasMatch(colorString)) {
      String hexColor = colorString.replaceAll('#', '');
      int value = int.parse(hexColor, radix: 16);
      return Color(value).withOpacity(1.0);
    } else {
      throw FormatException("Invalid color format: $colorString");
    }
  }

  Color getComplementaryColor(Color color) {
    int red = 255 - color.red;
    int green = 255 - color.green;
    int blue = 255 - color.blue;
    return Color.fromARGB(255, red, green, blue);
  }

  double calculateColorDistance(Color color1, Color color2) {
    int redDiff = color1.red - color2.red;
    int greenDiff = color1.green - color2.green;
    int blueDiff = color1.blue - color2.blue;
    return sqrt(redDiff * redDiff + greenDiff * greenDiff + blueDiff * blueDiff)
        .toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            )
          : SingleChildScrollView(
              controller: scrollController,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (selectedOuterUrl != null)
                    _buildTitleWithDivider(selectedOuterUrl!),
                  if (selectedTopUrl != null)
                    _buildTitleWithDivider(selectedTopUrl!),
                  if (selectedBottomUrl != null)
                    _buildTitleWithDivider(selectedBottomUrl!),
                ],
              ),
            ),
    );
  }

  Widget _buildTitleWithDivider(String urls) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        urls.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    )),
              )
            : _buildGridView(urls),
      ],
    );
  }

  Widget _buildGridView(String urls) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.grey,
                ),
              )
            : Row(
                children: [
                  Container(
                    width: screenWidth * 0.3,
                    height: screenWidth * 0.3,
                    child: SizedBox(
                      child: Image.network(
                        urls,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }
}
