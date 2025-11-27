import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'weather/model.dart';
import '../recommand.dart';
import 'settingFile/option.dart';
import '../style.dart';
//==========================
//아이디 ssss1111@naver.com
//비밀번호 ssss1111*
//==========================

class MainScreen extends StatefulWidget {
  MainScreen({this.weatherData});
  final dynamic weatherData;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  WeatherModel weather = WeatherModel();
  Style style = Style();

  String? cityName;
  int? temp; // 현재 온도
  String? des;
  String? weatherIcon;
  late List<String> styleList = [];
  String? weatherInfo;
  late List<String> urls = [];
  var date = DateTime.now();

  String? selectedStyle;
  List<String> styles2 = [
    '캐주얼',
    '스트릿',
    '스포티',
    '격식',
    '아웃도어',
    '빈티지',
    '시크',
  ];

  @override
  void initState() {
    super.initState();
    updateData(widget.weatherData);
    styles2.sort((a, b) => a.length.compareTo(b.length)); // 글씨 긴 순서대로 정렬
  }

  void updateData(dynamic weatherData) {
    double temp2 = weatherData['main']['temp'].toDouble();
    int condition = weatherData['weather'][0]['id'].toInt();
    temp = temp2.round();
    cityName = weatherData['name'];
    des = weatherData['weather'][0]['description'];
    weatherIcon = weather.getWeatherIcon(condition);
    weatherInfo = weather.getWeatherInfo(condition);
    styleList = style.returnStyle(temp!);
  }

  String getSystemTime() {
    var now = DateTime.now();
    return DateFormat("h:mm a").format(now);
  }

  @override
  Widget build(BuildContext context) {
    // 화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    print('temp: $temp');
    print('screenHeight : $screenHeight');
    print('screenWidth : $screenWidth');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: false, // 앱바 뒤로가기 버튼 비활성화
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Image.asset('assets/images/hanger.png',
            width: screenWidth * 0.08, fit: BoxFit.contain),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Option();
                    },
                  ),
                );
              },
              icon: Icon(Icons.settings))
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.05),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Color.fromARGB(255, 211, 211, 211))),
                  width: screenWidth * 0.86,
                  height: screenHeight * 0.45,
                  child: Column(
                    children: [
                      //------------------------날짜 및 시간----------------------------
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(screenWidth * 0.06,
                                screenHeight * 0.03, 0.0, 0.0),
                            child: Text(
                              DateFormat('yyyy년 MM월 d일 EEEE', 'ko_KR')
                                  .format(date),
                              style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontFamily: 'Jua'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.06,
                          ),
                          Text(
                            '오늘 대구 날씨는?',
                            style: TextStyle(
                                fontSize: screenWidth * 0.075,
                                fontFamily: 'Jua'),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                top: screenHeight * 0.07,
                              ),
                              child: Image.asset('$weatherIcon')),
                          SizedBox(
                            width: screenWidth * 0.02,
                          ),
                          Container(
                              margin: EdgeInsets.only(top: screenHeight * 0.07),
                              child: Text(
                                '$temp',
                                style: TextStyle(
                                  fontFamily: 'Jua',
                                  fontSize: screenWidth * 0.15,
                                ),
                              )),
                        ],
                      ),
                      //------------------------날씨 아이콘 및 기상 상황----------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$weatherInfo',
                              style: TextStyle(
                                fontFamily: 'Jua',
                                fontSize: screenWidth * 0.071,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.06,
                  ),
                  Text(
                    '오늘은  ',
                    style: TextStyle(
                      fontFamily: 'Jua',
                      fontSize: screenWidth * 0.065,
                    ),
                  ),

                  // Text(
                  //   '$styleList',
                  //   style: TextStyle(
                  //       fontFamily: 'Jua',
                  //       fontSize: screenWidth * 0.06,
                  //       color: Color.fromARGB(115, 27, 25, 39)),
                  // ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: screenWidth * 0.06,
                  ),
                  Container(
                    width: screenWidth * 0.9,
                    child: Wrap(
                      spacing: 3.0, // 버튼 사이의 수평 간격
                      children: styleList.map((style) {
                        return Text('$style ',
                            // style: TextStyle(
                            //     fontFamily: 'Jua',
                            //     fontSize: screenWidth * 0.06,
                            //     color: Color.fromARGB(115, 27, 25, 39)),
                            style: TextStyle(
                              fontFamily: 'Jua',
                              fontSize: screenWidth * 0.06,
                              color: Color.fromARGB(115, 27, 25, 39),
                            ));
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Wrap(
                spacing: 3.0, // 버튼 사이의 수평 간격
                children: styles2.map((style) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedStyle == style
                          ? Colors.grey // 선택된 버튼의 배경색
                          : Colors.white, // 선택되지 않은 버튼의 배경색
                      elevation: 0.0,
                      side: BorderSide(
                        color: Colors.grey, // 테두리 색상
                        width: 0.9, // 테두리 두께
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        selectedStyle = style;
                      });
                    },
                    child: Text(
                      '#$style',
                      style: TextStyle(
                        color: selectedStyle == style
                            ? Colors.white // 선택된 버튼의 텍스트 색상
                            : Colors.grey, // 선택되지 않은 버튼의 텍스트 색상
                        fontFamily: 'Jua',
                      ),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenHeight * 0.04,
                    top: screenHeight * 0.02), // 원하는 공백 크기로 조정
                child: Recommand(
                  key: ValueKey(selectedStyle),
                  param: temp,
                  param2: selectedStyle,
                ), // Recommand 위젯을 직접 사용
              ),
            ],
          ),
        );
      }),
    );
  }
}
