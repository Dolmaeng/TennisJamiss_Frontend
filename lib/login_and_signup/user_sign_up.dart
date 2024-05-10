import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class UserSignUp extends StatefulWidget {
  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '일반 사용자 회원가입',
          style: TextStyle(
            color: Color(0xFF222222),
            fontSize: 14,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w700,
            height: 1.0,
            letterSpacing: -0.14,
            ),
          ),
          centerTitle: true,
      ),
      body: FormWidget(),
    );
  }
}

class FormWidget extends StatefulWidget {
  @override
  _FormWidgetState createState() => _FormWidgetState();
}


class _FormWidgetState extends State<FormWidget> {
  // 텍스트 입력 필드에 입력된 값들을 저장할 변수들
  final user_formKey = GlobalKey<FormState>();
  String ID =  '';
  String email = '';
  String password = '';
  String confirmPassword = '';
  String name = '';
  DateTime user_birthdate = DateTime.now();
  int age = 0;
  String gender = 'Male';
  double ntrp = 1.0;
  final List<bool> user_genderToggle = [true, false];

  //사용자의 포커스 여부
  bool _isFocused = false;

  // 아이디 중복 확인
  bool isIDverification = false;

  // 이메일 인증 및 확인
  final user_emailController = TextEditingController();
  final user_verificationCodeController = TextEditingController();
  bool isSendingVerification = false;
  bool isVerifyingCode = false;

  // 인증코드 전송 API call
  void sendVerificationCode() async {
    setState(() {
      isSendingVerification = true;
    });
    final response = await http.post(
      Uri.parse('URL/api/users/send-verification-email'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer',
      },
    );
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData['message']);
      // Handle success, such as showing a confirmation dialog or toast
    }
    else {
      // Handle failure, such as showing an error dialog or toast
      var responseData = json.decode(response.body);
      print(responseData['message']);
    }
    setState(() {
      isSendingVerification = false;
    });
  }

  Future<void> verifyCode() async {
    setState(() {
      isVerifyingCode = true;
    });

    // Replace with your API call
    final response = await http.post(
      Uri.parse('URL/api/users/verify-code'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'code': user_verificationCodeController.text, // Assuming you collect this from a text field
      }),
    );

    if (response.statusCode == 200) {
      // Handle code verification success
    } else {
      // Handle failure
    }

    setState(() {
      isVerifyingCode = false;
    });
  }

  //날짜 설정 기능
  final birthdayController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      helpText: '2024.01.01',
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        birthdayController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
  //나이 계산
  int calculateAge(DateTime birthdate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthdate.year;
    if (currentDate.month < birthdate.month ||
        (currentDate.month == birthdate.month && currentDate.day < birthdate.day)) {
      age--;
    }
    return age;
  }

      // 일반 사용자 회원가입 화면
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          key: user_formKey,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 39),
                          child: Text('아이디',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: -0.10,
                              ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: 313,
                      height: 30,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                          borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            color: Color(0xFF919191),
                            fontSize: 8,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.0,
                            letterSpacing: -0.08,
                            ),
                          textAlignVertical: TextAlignVertical(y:1.0),
                          // 포커스를 받았을 때 상태 업데이트
                          onTap: () {
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
                          controller: TextEditingController(text: ID),
                          // 아이디 입력 형식 검사
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '아이디는 공란이어서는 안됩니다.';
                            }
                            else if (value.length < 6 || value.length > 20) {
                              return '아이디는 6-20자 사이여야 합니다.';
                            }
                              return null;
                            },
                          onSaved: (value) => ID = value!,
                          onChanged: (value) {
                            ID = value;
                          },
                          decoration: InputDecoration(
                          // 입력창 배경은 회색, 선택할 때 흰색
                            hintText: '아이디를 입력해주세요 (6-20자)',
                            suffixIcon: isIDverification ? Container(
                                    width: 73,
                                    height: 22,
                                    margin: EdgeInsets.all(4),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                )
                              : ElevatedButton(
                                onPressed: verifyCode, // id 검증임 수정 필요
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  fixedSize: Size(73, 22),
                                  backgroundColor: Color(0xFFA7A7A7),
                                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                ),
                                child: Text(
                                    '중복 확인',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 8,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.0,
                                      letterSpacing: -0.08,
                                      ),
                                    ),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Color(0xFF464EFF))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red))),
                        ),
                    ),
                    SizedBox(height: 14),
                    // 비밀번호
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 39),
                          child: Text(
                            textAlign: TextAlign.start,
                            '비밀번호',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: -0.10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: 313,
                      height: 30,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xFF919191),
                          fontSize: 8,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: -0.08,
                        ),
                        textAlignVertical: TextAlignVertical(y:1.0),
                        // 포커스를 받았을 때 상태 업데이트
                        onTap: () {
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
                        controller: TextEditingController(text: password),
                        // 비밀번호 입력 형식 검사
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호를 입력해주세요';
                          } else if (value.length < 8) {
                            return '비밀번호는 8자 이상이어야 합니다.';
                          }
                          return null;
                        },
                        onSaved: (value) => password = value!,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: InputDecoration(
                            hintText: '비밀번호를 입력해주세요',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Color(0xFF464EFF))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    SizedBox(height: 14),
                    // 비밀번호 확인
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 39),
                          child: Text(
                            textAlign: TextAlign.start,
                            '비밀번호 확인',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: -0.10,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Container(
                      width: 313,
                      height: 30,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: TextFormField(
                        style: TextStyle(
                          color: Color(0xFF919191),
                          fontSize: 8,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: 1.0,
                          letterSpacing: -0.08,
                        ),
                        textAlignVertical: TextAlignVertical(y:1.0),
                        // 포커스를 받았을 때 상태 업데이트
                        onTap: () {
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
                        controller: TextEditingController(text: confirmPassword),
                        // 비밀번호 입력 형식 검사
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '비밀번호 확인란을 입력해주세요';
                          } else if (value != password) {
                            return '비밀번호와 일치하지 않습니다.';
                          }
                          return null;
                        },
                        onSaved: (value) => confirmPassword = value!,
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        decoration: InputDecoration(
                            hintText: '비밀번호를 다시 입력해주세요',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Color(0xFF464EFF))),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red))),
                      ),
                    ),
                    SizedBox(height: 23),
                    // 이름 생년월일
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 39),
                          child: Text(
                            textAlign: TextAlign.start,
                            '이름',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.0,
                              letterSpacing: -0.10,
                            ),
                           ),
                          ),
                        SizedBox(width: 164),
                        // 임시방면, 화면에 최적화된 방법 찾아야 함
                        Text(
                          textAlign: TextAlign.start,
                          '생년월일',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.0,
                            letterSpacing: -0.10,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: 38),
                        Container(
                          width: 175,
                          height: 30,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                              borderRadius: BorderRadius.circular(5),
                              ),
                          ),
                          child : TextFormField(
                            style: TextStyle(
                              color: Color(0xFF919191),
                              fontSize: 8,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 1.0,
                              letterSpacing: -0.08,
                              ),
                            textAlignVertical: TextAlignVertical(y:1.0),
                            // 포커스를 받았을 때 상태 업데이트
                            onTap: () {
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
                            controller: TextEditingController(text: name),
                            //이름 형식 검사 (추가 필요)
                            onSaved: (value) => name = value!,
                            onChanged: (value) {
                              name = value;
                            },
                            decoration: InputDecoration(
                              hintText: '이름을 입력해주세요',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.grey)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Color(0xFF464EFF))),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(color: Colors.red))),
                            ),
                          ),
                        SizedBox(width: 10),
                        Container(
                            width: 125,
                            height: 30,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: Color(0xFFD3D3D3)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: ListTile(
                              dense: true,
                              visualDensity: VisualDensity(vertical: -4),
                              leading: Icon(Icons.calendar_today,
                              size: 15,),
                              title: Text(DateFormat('yyyy.MM.dd',).format(user_birthdate),
                                style: TextStyle(
                                  color: Color(0xFF919191),
                                  fontSize: 8,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                  height: 1.0,
                                  letterSpacing: -0.08,
                                ),
                              ),
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: user_birthdate,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );
                                if (picked != null && picked != user_birthdate) {
                                  setState(() {
                                    user_birthdate = picked;
                                    age = calculateAge(picked);
                                  });
                                }
                              },
                            ),
                        ),

                      ],
                    )
                ]
              ),
            ),
          ),
        );
      }
}