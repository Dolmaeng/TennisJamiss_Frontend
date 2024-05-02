import 'package:flutter/material.dart';

class court_register_map extends StatelessWidget {
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
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: -0.14,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '추가 예정',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    letterSpacing: -0.20
                ),
              ),
            ]
        )
    );
  }
}