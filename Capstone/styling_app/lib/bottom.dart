import 'package:flutter/material.dart';
import 'package:styling_app/main_screen.dart';
import './DressRoom/dress_room.dart';
import './tablecalendar.dart';

class BottomPage extends StatefulWidget {
  BottomPage({this.parseWeatherData});
  final dynamic parseWeatherData;

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  dynamic _selectedIndex = 1;
  PageController _pageController = PageController(initialPage: 1);

  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    pages = [
      DressRoom(),
      MainScreen(weatherData: widget.parseWeatherData),
      TableCalendarScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    // 화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    List<BottomNavigationBarItem> bottomItems = [
      BottomNavigationBarItem(label: '1번', icon: Icon(Icons.face_outlined)),
      BottomNavigationBarItem(label: '2번', icon: Icon(Icons.home)),
      BottomNavigationBarItem(label: '3번', icon: Icon(Icons.book_outlined)),
    ];

    Future<bool?> _showBackDialog() {
      return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Are you sure you want to leave this page?',
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Nevermind'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Leave'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        },
      );
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog();
      },
      child: Scaffold(
        body: PageView(
          controller: _pageController,
          children: pages,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(.60),
          selectedFontSize: screenWidth * 0.01,
          unselectedFontSize: screenWidth * 0.007,
          currentIndex: _selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          items: bottomItems,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
