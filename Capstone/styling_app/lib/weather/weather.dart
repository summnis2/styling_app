import 'package:flutter/material.dart';
import 'location.dart';
import 'network.dart';
import '../bottom.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = '734bd6664f44f8bca848333e4dcc9182';

class weatherInfo extends StatefulWidget {
  const weatherInfo({super.key});

  @override
  State<weatherInfo> createState() => _weatherInfoState();
}

class _weatherInfoState extends State<weatherInfo> {
  late double latitude3;
  late double longitude3;
  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude3 = location.latitude2;
    longitude3 = location.longitude2;
    Network network = Network(
        'https://api.openweathermap.org/data/2.5/weather?q=Daegu&lang=kr&appid=$apiKey&units=metric');
    var weatherData = await network.getJsonData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return BottomPage(
            parseWeatherData: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SpinKitFadingFour(
            color: const Color.fromARGB(255, 83, 83, 83), // 색상 설정
            size: 50.0, // 크기 설정
            duration: Duration(seconds: 2), //속도 설정
          ),
          SizedBox(height: 10.0),
          Text(
            'Loading',
            style: GoogleFonts.daiBannaSil(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      )),
    );
  }
}
