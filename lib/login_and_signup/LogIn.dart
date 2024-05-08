import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:tennis_login/login_and_signup/find_id.dart';
import 'package:tennis_login/login_and_signup/find_pw.dart';
import 'package:tennis_login/login_and_signup/sign_up.dart';
import 'package:tennis_login/login_and_signup/user.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:tennis_login/general_user/match_Info.dart';



class LogIn extends StatefulWidget {
  LogIn({required Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _isFocused = false;
  // 사용자의 포커스 여부
  final user_formKey = GlobalKey<FormState>();
  // 아이디와 비밀번호를 입력하고 MongoDB와 비교
   Future save() async {
    var res = await http.post('URI/api/users/login' as Uri,
        headers: <String, String>{
          'Context-Type': 'json 파일'
        },
        body: <String, String>{
          'email' : user.email,
          'password' : user.password
        }
    );
    print(res.body);
    // 서버로부터 받은 데이터 확인
    //.push(
      //context, new MaterialPageRoute(builder: (context) => TennisMatch()));
      //로그인 후 테니스 매치화면(사용자 메인화면 현 TennisMatch())으로 이동
      //로그인 버튼은 266줄 즈음에 있음
  }



  // 로그인 폼
  User user = User('','');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                // 테니스 재미쓰 로고
                    // Image.asset(
                    //     'images/tennis.logo.svg',
                    //     width: 80,
                    //     height: 165
                    //   ),
                    SvgPicture.asset(
                      'images/tennis.logo.svg', 
                        width: 100, 
                        height: 100,
                      ),
                    SizedBox(height: 29),
                    Container(
                        width: 231,
                        height: 33,
                        child: TextFormField(
                          style: TextStyle(
                            color: Color(0xFF646464),
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            letterSpacing: -0.10,
                            ),
                          textAlignVertical: TextAlignVertical(y:1.0),
                          onTap: () {
                            // 포커스를 받았을 때 상태 업데이트
                            setState(() {
                              _isFocused = true;
                            });
                          },
                          // 포커스를 잃었을 때 상태 업데이트
                          onFieldSubmitted: (value) {
                            setState(() {
                              _isFocused = false;
                            });
                          },
                          controller: TextEditingController(text: user.email),
                          onChanged: (value) {
                            user.email = value;
                          },
                          // 아이디 입력 창 유효성 검사
                          validator: (value) {
                            // 공란 입력
                            if (value!.isEmpty) {
                              return '아이디를 입력하세요.';
                            }
                            // 형식에 적합한 아이디 입력
                            else if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)){
                              return null;
                            }
                            // 그 외 형식에 부적합
                            else {
                              return '유효한 아이디를 입력해 주세요.';
                            }
                          },
                          decoration: InputDecoration(
                            // 입력창 배경은 회색, 선택할 때 흰색
                            filled: true,
                            fillColor: _isFocused ? Colors.white : Color(0xFFEDEDED),
                            hintText: '아이디를 입력해주세요',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xFFEDEDED))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red))),
                      )
                  ),
                  SizedBox(height: 13),
                  Container(
                      width: 231,
                      height: 33,
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xFF646464),
                          fontSize: 10,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 0,
                          letterSpacing: -0.10,
                        ),
                        textAlignVertical: TextAlignVertical(y:1.0),
                        onTap: () {
                          // 포커스를 받았을 때 상태 업데이트
                          setState(() {
                            _isFocused = true;
                          });
                        },
                        // 포커스를 잃었을 때 상태 업데이트
                        onFieldSubmitted: (value) {
                          setState(() {
                            _isFocused = false;
                          });
                        },
                        controller: TextEditingController(text: user.password),
                        onChanged: (value) {
                          user.password = value;
                        },
                        // 비밀번호 입력 창 유효성 검사
                        validator: (value) {
                          if (value!.isEmpty) {
                            return '비밀번호를 입력하세요';
                          }
                          return null;
                        },
                        // 비밀번호 숨김
                        obscureText: true,
                        decoration: InputDecoration(
                          // 입력창 배경은 회색, 선택할 때 흰색
                            filled: true,
                            fillColor: _isFocused ? Colors.white : Color(0xFFEDEDED),
                            hintText: '비밀번호를 입력해주세요',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Color(0xFFEDEDED))),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.black)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.red))),
                      )
                  ),
                  // 아이디 찾기, 비밀번호 찾기
                  Padding(
                      padding: const EdgeInsets.fromLTRB(133, 0, 0, 0),
                      child: Row(
                          children: [
                            // 아이디 찾기
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FindID())
                                  );
                                },
                                child: Text(
                                  "아이디 찾기",
                                  style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 8,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    height: 0,
                                  ),
                                )
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => FindPassword())
                                  );
                                },
                                child: Text(
                                  "비밀번호 찾기",
                                  style: TextStyle(
                                    color: Color(0xFF7A7A7A),
                                    fontSize: 8,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.underline,
                                    height: 0,
                                  ),
                                )
                            )
                          ]
                      )
                  ),
                  SizedBox(height: 74),
                  // 회원가입 버튼
                  Container(
                          height: 33,
                          width: 231,
                          child: ElevatedButton(
                            style : ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1, color: Color(0xFF464EFF)),
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUp())
                              );
                            },
                            child: Text(
                                '회원가입',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Color(0xFF464EFF),
                                    fontSize: 10,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.10,
                                )
                            ),
                          ),
                      ),
                  SizedBox(height: 10),
                  Container(
                    height: 33,
                    width: 231,
                    child: ElevatedButton(
                      style : ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF464EFF),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFF464EFF)),
                              borderRadius: BorderRadius.circular(20)
                          )
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => matching_Info())
                        );
                      },
                      child: Text(
                          '로그인',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w700,
                            height: 0,
                            letterSpacing: -0.10,
                          )
                      ),
                    ),
                  ),
                ],
              )
            )
        )
      );
    }
}