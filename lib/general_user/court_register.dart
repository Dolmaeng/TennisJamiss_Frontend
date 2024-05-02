import 'package:flutter/material.dart';
import 'package:tennis_login/general_user/court_register_map.dart';

class court_register extends StatelessWidget {
  String tennis_court_name = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('예약 코트 등록하기',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 20,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
              height: 0,
              letterSpacing: -0.20,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                textAlign: TextAlign.center,
                "예약한 테니스장 이름을" + '\n' + "입력해주세요",
                style: TextStyle(
                  color: Color(0xFF222222),
                  fontSize: 20,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                  height: 0,
                  letterSpacing: -0.20,
                ),
              ),
              SizedBox(height: 20),
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
                      height: 0,
                      letterSpacing: -0.08,
                    ),
                    textAlignVertical: TextAlignVertical(y:1.0),
                    controller: TextEditingController(text: tennis_court_name),
                    onSaved: (value) => tennis_court_name = value!,
                    decoration: InputDecoration(
                      hintText: '테니스장 정보를 입력해주세요',
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
              SizedBox(height: 52),
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
                        MaterialPageRoute(builder: (context) => court_register_map())
                    );
                  },
                  child: Text(
                      '검색하기',
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
           ]
        )
    );
  }
}