import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Gender { male, female } // 성별 열거형 정의

class MembershipScreen extends StatefulWidget {
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController =
      TextEditingController(); // 닉네임 입력받는 컨트롤러
  final TextEditingController _idController =
      TextEditingController(); // 아이디 입력받는 컨트롤러
  final TextEditingController _passwordController =
      TextEditingController(); // 비밀번호 입력받는 컨트롤러
  final TextEditingController _confirmPasswordController =
      TextEditingController(); // 비밀번호 확인 입력받는 컨트롤러

  // ignore: unused_field
  String _passwordErrorText = ''; // 암호 유효성 검사 오류 메시지
  Gender selectedGender = Gender.male; // 기본적으로 선택된 성별

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "회원가입",
          style: TextStyle(
            color: Colors.black, // 텍스트 색 검은색
            fontWeight: FontWeight.bold, // 글꼴 폰트 무게
            fontSize: 20, // 글꼴 크기
          ),
        ),
        centerTitle: true,
        // 앱 바 타이틀 가운데 정렬
        elevation: 0.0,
        backgroundColor: Colors.white,
        toolbarHeight: 80.0, // 앱 바 높이 조정
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // 모든 방향에 안쪽 여백 추가
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //위젯 세로 중앙 정렬
              crossAxisAlignment: CrossAxisAlignment.center, //위젯 가로 중앙 정렬
              children: [
                TextField(
                  controller: _nicknameController, // 닉네임 입력 필드에 닉네임 컨트롤러 연결
                  decoration: InputDecoration(
                    labelText: "닉네임",
                  ),
                ),
                SizedBox(height: 15), //공백
                TextField(
                  controller: _idController, // 아이디 입력 필드에 아이디 컨트롤러 연결
                  decoration: InputDecoration(
                    labelText: "아이디",
                  ),
                ),
                SizedBox(height: 15), //공백
                TextFormField(
                  controller: _passwordController, // 비밀번호 입력 필드에 비밀번호 컨트롤러 연결
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    //errorText: _passwordErrorText, // 비밀번호 오류 메시지 표시
                  ),
                  obscureText: true, // 입력 내용을 비밀번호 형태로 가려서 표시
                ),
                SizedBox(height: 15), //공백
                TextFormField(
                  controller:
                      _confirmPasswordController, // 비밀번호 확인 입력 필드에 컨트롤러 연결
                  decoration: InputDecoration(
                    labelText: "비밀번호 확인",
                  ),
                  obscureText: true, // 입력 내용을 비밀번호 형태로 가려서 표시
                ),
                SizedBox(height: 50), // 위젯 사이에 공간 추가
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly, //가로로 중앙 정렬해서 공간 맞춤
                  children: [
                    OutlinedButton(
                      // "이전" 버튼 클릭 시 실행
                      onPressed: () {
                        // 로그인 화면으로 돌아감
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white, // 버튼 배경 검은색
                        minimumSize: Size(150, 50), // 버튼 크기
                        elevation: 0.0,
                      ),
                      child: Text(
                        "이전",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 112, 112, 112),
                            fontFamily: 'Jua',
                            fontSize: 17),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        // 메인 화면으로 이동
                        _register();
                      },
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white, // 버튼 배경 검정색
                          minimumSize: Size(150, 50), // 버튼 크기
                          elevation: 0.0),
                      child: Text(
                        "다음",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 102, 101, 101),
                            fontFamily: 'Jua',
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _register() async {
    if (_passwordController.text == _confirmPasswordController.text) {
      try {
        final UserCredential result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _idController.text, password: _passwordController.text);

        if (result.user != null) {
          String g = describeEnum(selectedGender);
          await FirebaseFirestore.instance
              .collection('user')
              .doc(result.user!.uid)
              .set({
            'nickname': _nicknameController.text,
            'email': _idController.text,
            'password': _passwordController.text,
            'gender': g,
          });
        }

        showDialog(
          context: context, // 현재 화면 컨텍스트 사용
          builder: (BuildContext context) {
            // 대화 상자 내용 정의
            return AlertDialog(
              title: Text("회원가입 완료"), // 대화 상자 제목
              content: Text("로그인 창으로 이동합니다."), // 대화 상자 내용
              actions: [
                TextButton(
                  // 대화 상자 하단에 버튼 추가
                  onPressed: () {
                    // "확인" 버튼 누르면 대화 상자를 닫음
                    Navigator.pushNamed(context, '/');
                  },
                  child: Text("확인"), // 버튼 텍스트
                ),
              ],
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showDialog(
            context: context, // 현재 화면 컨텍스트 사용
            builder: (BuildContext context) {
              // 대화 상자 내용 정의
              return AlertDialog(
                title: Text("다시하세요"), // 대화 상자 제목
                content: Text("비밀번호를 적어도 6자리 이상 입력해주세요."), // 대화 상자 내용
                actions: [
                  TextButton(
                    // 대화 상자 하단에 버튼 추가
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white, elevation: 0),
                    onPressed: () {
                      // "확인" 버튼 누르면 대화 상자를 닫음
                      Navigator.of(context).pop();
                    },
                    child: Text("확인"), // 버튼 텍스트
                  ),
                ],
              );
            },
          );
        } else if (e.code == 'email-already-in-use') {
          showDialog(
            context: context, // 현재 화면 컨텍스트 사용
            builder: (BuildContext context) {
              // 대화 상자 내용 정의
              return AlertDialog(
                title: Text("다시하세요"), // 대화 상자 제목
                content: Text("이미 존재하는 이메일입니다."), // 대화 상자 내용
                actions: [
                  TextButton(
                    // 대화 상자 하단에 버튼 추가
                    onPressed: () {
                      // "확인" 버튼 누르면 대화 상자를 닫음
                      Navigator.of(context).pop();
                    },
                    child: Text("확인"), // 버튼 텍스트
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
        print(e);
      }
    } else if (_passwordController.text != _confirmPasswordController.text) {
      showDialog(
        context: context, // 현재 화면 컨텍스트 사용
        builder: (BuildContext context) {
          // 대화 상자 내용 정의
          return AlertDialog(
            title: Text("다시하세요"), // 대화 상자 제목
            content: Text("비밀번호가 일치하지 않습니다."), // 대화 상자 내용
            actions: [
              TextButton(
                // 대화 상자 하단에 버튼 추가
                onPressed: () {
                  // "확인" 버튼 누르면 대화 상자를 닫음
                  Navigator.of(context).pop();
                },
                child: Text("확인"), // 버튼 텍스트
              ),
            ],
          );
        },
      );
    }
  }
}
