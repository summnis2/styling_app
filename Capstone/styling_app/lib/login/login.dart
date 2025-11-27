import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController =
      TextEditingController(); // 사용자 아이디 입력 받는 컨트롤러
  final TextEditingController _passwordController =
      TextEditingController(); // 사용자 비밀번호 입력 받는 컨트롤러

  Future<void> _handleLogin() async {
    // 로그인 구현

    String id = '';
    String password = '';

    id = _idController.text;
    password = _passwordController.text;

    if (id == '') {
      showSnackbar(context, "아이디를 입력해주세요.");
    } else if (password == '') {
      showSnackbar(context, "비밀번호를 입력해주세요.");
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: id, password: password);
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
    } on FirebaseAuthException catch (error) {
      print('s');
      switch (error.code) {
        case "invalid-email":
          showSnackbar(context, "이메일 형식이 유효하지 않습니다.");
          break;
        case "user-disabled":
          showSnackbar(context, error.code);
          break;
        case "user-not-found":
          showSnackbar(context, error.code);
          break;
        case "wrong-password":
          showSnackbar(context, error.code);
          break;
      }
    }
  }

  void _handleRegister() {
    // '회원가입' 버튼을 누를 때 회원가입 화면으로 이동
    Navigator.pushNamed(context, '/membership');
  }

  @override
  Widget build(BuildContext context) {
    //화면 가로, 세로 크기
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          scrolledUnderElevation: 0,
          title: Text(""),
          centerTitle: true, // 앱 바 타이틀 가운데 정렬
          backgroundColor: Colors.white, // 앱 바 색 흰색
          elevation: 0.0, // 앱 바 그림자 지움
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // 내부 여백 네 방향 모두 16.0
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 위젯들을 수직 방향 중앙에 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 위젯들을 수평 방향 중앙에 정렬
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 100,
                height: 100,
              ),
              // Text(
              //   "오늘 뭐 입지",
              //   style: TextStyle(fontSize: 45, fontFamily: 'Jua'),
              // ),
              SizedBox(
                height: 50,
              ),
              TextField(
                controller: _idController, // 텍스트 필드에 컨트롤러 연결
                decoration: InputDecoration(
                  labelText: "아이디",
                  border: OutlineInputBorder(
                    //테두리 설정
                    borderSide: BorderSide(
                      color: Colors.black, // 테두리 검정색
                      width: 2.0, // 테두리 두께
                    ),
                    borderRadius: BorderRadius.circular(10.0), // 테두리 모서리 둥글게
                  ),
                ),
              ),
              SizedBox(height: 16.0), // 비밀번호 필드 위에 여백 추가
              TextField(
                controller: _passwordController, // 텍스트 필드에 컨트롤러 연결
                decoration: InputDecoration(
                  labelText: "비밀번호",
                  border: OutlineInputBorder(
                    //테두리 설정
                    borderSide: BorderSide(
                      color: Colors.black, // 테두리 색 검정색
                    ),
                    borderRadius: BorderRadius.circular(10.0), // 테두리 둥글게
                  ),
                ),
                obscureText: true, // 비밀번호 필드의 입력 내용 안보이게
              ),
              SizedBox(height: 20), // 버튼 위에 여백 추가
              Container(
                width: screenWidth,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: _handleLogin, // 버튼 누르면 handleLogin 실행됨
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent,
                    elevation: 0.0,
                    backgroundColor: Colors.black, // 버튼 배경 검은색

                    shape: RoundedRectangleBorder(
                        //모서리를 둥글게
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Jua',
                        fontSize: 18), // 텍스트 흰색
                  ),
                ),
              ),
              //SizedBox(height: 10), // 버튼 아래에 여백 추가
              TextButton(
                onPressed: _handleRegister, // 버튼 누르면 handleLogin 실행
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white, // 텍스트 색 검정색
                  minimumSize: Size(150, 50), // 버튼 크기 설정
                  foregroundColor: Colors.white,
                  side: BorderSide(
                    color: Colors.white,
                    width: 0.2,
                  ), //테두리 스타일
                ),
                child: Text(
                  "회원가입",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontFamily: 'Jua',
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(BuildContext context, String errorCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorCode),
        backgroundColor: Colors.black12,
      ),
    );
  }
}
