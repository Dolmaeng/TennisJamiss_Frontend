import 'package:flutter/material.dart';

class SignUpDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check,
                    size: 43,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 43),
                  Text(
                    textAlign : TextAlign.center,
                    '회원가입이\n완료되었습니다',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: -0.20
                    ),
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    child: Text('서비스 시작하기!'),
                    onPressed: () {
                      // Navigate to the next page or reset the navigation stack
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF464EFF),
                      padding: EdgeInsets.symmetric(horizontal: 101, vertical: 10),
                    ),
                  ),
                ]
            )
        )
    );
  }
}