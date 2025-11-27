import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'fashion_memory.dart';

ScrollController scrollController = ScrollController();
typedef OnDaySelected = void Function(
    DateTime selectedDay, DateTime focusedDay);

class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);

  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends State<TableCalendarScreen> {
  DateTime selectedDay = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    DateTime date = DateTime.now(); // 선택한 날짜를 입력받을 변수 선언
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        title: Icon(
          Icons.calendar_month_outlined,
          size: screenWidth * 0.08,
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 2000,
          child: Stack(
            children: [
              TableCalendar(
                locale: 'ko_KR', // 언어 설정 한국어
                firstDay: DateTime.utc(2020, 01, 01), //달력 처음 시작 날짜
                lastDay: DateTime.utc(2030, 01, 01), //마지막 날짜
                focusedDay: DateTime.now(), //오늘 날짜에 표시

                onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
                  // 선택된 날짜의 상태를 갱신
                  setState(() {
                    this.selectedDay = selectedDay;
                    this.focusedDay = focusedDay;
                    date = selectedDay;

                    showDialog(
                        barrierDismissible: true, // 바깥 영역 터치시 닫을지 여부
                        context: context,
                        builder: (context) {
                          return Camera(param: date);
                        });
                  });
                },
                selectedDayPredicate: (DateTime day) {
                  // selectedDay 와 동일한 날짜의 모양을 바꿔줌.

                  return isSameDay(selectedDay, day);
                },
                rowHeight: 80, //열 높이 조절
                headerStyle: const HeaderStyle(
                  //달력 꾸미기
                  titleCentered: true, //날짜 가운데 정렬
                  formatButtonVisible: false, //format버튼 노출 여부 (제한)
                  titleTextStyle: TextStyle(
                    fontSize: 20.0, //날짜 폰트 사이즈
                    color: Colors.black, //날짜 폰트 컬러
                    fontFamily: 'Jua',
                  ),
                  headerPadding: EdgeInsets.symmetric(vertical: 4.0),
                  leftChevronIcon: Icon(
                    Icons.arrow_back_ios_new, //달력 월 이동 화살표
                    size: 20.0,
                  ),
                  rightChevronIcon: Icon(
                    Icons.arrow_forward_ios_outlined, //달력 월 이동 화살표
                    size: 20.0,
                  ),
                ),

                calendarStyle: CalendarStyle(
                    outsideDaysVisible: true, //이전, 다음 달 날짜 보기
                    todayTextStyle: const TextStyle(
                      //오늘 날짜 꾸미기
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'Jua',
                    ),
                    todayDecoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 225, 231),
                      shape: BoxShape.circle,
                    ),

                    //선택된 날짜 꾸미기
                    selectedTextStyle: const TextStyle(
                      fontFamily: 'Jua',
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 1.5)),
                    defaultTextStyle: const TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Jua',
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
