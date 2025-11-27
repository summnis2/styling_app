import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:styling_app/DressRoom/add_dress.dart';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({Key? key}) : super(key: key);

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _getImageAndUpload(ImageSource source) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final Map<String, dynamic>? result = await sendImageToServer(image);
        if (result != null &&
            result.containsKey('result_image_url') &&
            result.containsKey('rgb_text')) {
          final XFile? processedImage =
              await _downloadImage(result['result_image_url']);
          if (processedImage != null) {
            // rbg~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            print('RGB Color: ${result['rgb_text']}');
            print('matching_palette: ${result['matching_palette']}');

            setState(() {
              _isLoading = false;
            });

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (BuildContext context) {
                return AddDress(image: processedImage, rbg: result['rgb_text']);
              }),
            );
          } else {
            _showErrorSnackBar('Failed to download processed image.');
          }
        } else {
          _showErrorSnackBar(
              'Failed to get the processed image URL or RGB text.');
        }
      }
    } catch (e) {
      _showErrorSnackBar('Error: $e');
      print('Error in _getImageAndUpload: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }



  Future<Map<String, dynamic>?> sendImageToServer(XFile image) async {
    final Uri serverUrl = Uri.parse('http://172.20.10.5:5000/upload');
    var request = http.MultipartRequest('POST', serverUrl);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      var response = await request.send().timeout(Duration(seconds: 120));
      if (response.statusCode == 200) {
        String responseString = await response.stream.bytesToString();
        var data = jsonDecode(responseString);

        return data; // 이제 이미지 URL과 RGB 텍스트를 함께 반환합니다.
      } else {
        print('Failed to upload image: ${response.statusCode}');
        return null;
      }
    } on TimeoutException catch (_) {
      print('Timeout while sending image to server.');
      return null;
    } catch (e) {
      print('Error sending image to server: $e');
      return null;
    }
  }

  Future<XFile?> _downloadImage(String imageUrl) async {
    try {
      var response =
          await http.get(Uri.parse(imageUrl)).timeout(Duration(seconds: 120));
      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        XFile? imageFile = await saveImageData(imageData);
        return imageFile;
      } else {
        print('Failed to download image: ${response.statusCode}');
        return null;
      }
    } on TimeoutException catch (_) {
      print('Timeout while downloading image.');
      return null;
    } catch (e) {
      print('Error downloading image: $e');
      return null;
    }
  }

  Future<XFile?> saveImageData(Uint8List imageData) async {
    try {
      var now = DateTime.now();
      var formatter = DateFormat('yyyyMMddHHmmss');
      String formattedDate = formatter.format(now);
      int squareTime = pow(now.millisecondsSinceEpoch, 2).toInt();
      var random = Random();
      int randomNumber = random.nextInt(10000);
      int finalNumber = squareTime * randomNumber;

      String fileName = "${formattedDate}_$finalNumber";
      Directory tempDir = await getTemporaryDirectory();
      String tempFilePath = '${tempDir.path}/$fileName.png';
      await File(tempFilePath).writeAsBytes(imageData);
      return XFile(tempFilePath);
    } catch (e) {
      print('Error saving image data: $e');
      return null;
    }
  }

  void _showErrorSnackBar(String message) {
    setState(() {
      _isLoading = false;
    });

    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    //화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.2,
      child: Center(
        child: _isLoading
            ? Positioned.fill(
                child: Container(
                  height: screenHeight,
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: SpinKitFadingCircle(
                      color: Colors.white, // 색상 설정
                      size: 27.0, // 크기 설정
                      duration: Duration(seconds: 1), //속도 설정
                    ),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white, elevation: 0.0),
                      onPressed: () {
                        _getImageAndUpload(ImageSource.camera);
                      },
                      child: Container(
                          child: Row(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: screenHeight * screenWidth * 0.00009,
                            color: Colors.black,
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Text(
                            '카메라',
                            style: TextStyle(
                                fontSize: screenHeight * screenWidth * 0.00007,
                                fontFamily: 'Jua',
                                color: Colors.black),
                          )
                        ],
                      )),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white, elevation: 0.0),
                        onPressed: () {
                          _getImageAndUpload(ImageSource.gallery);
                        },
                        child: Container(
                            child: Row(
                          children: [
                            Icon(
                              Icons.photo_library_outlined,
                              size: screenHeight * screenWidth * 0.00009,
                              color: Colors.black,
                            ),
                            SizedBox(width: screenWidth * 0.04),
                            Text(
                              '갤러리',
                              style: TextStyle(
                                  fontSize:
                                      screenHeight * screenWidth * 0.00007,
                                  fontFamily: 'Jua',
                                  color: Colors.black),
                            )
                          ],
                        ))),
                  ],
                ),
              ),
      ),
    );
  }
}
