import 'package:flutter/material.dart';
import 'package:tennis_login/general_user/court_register.dart';

class matching_court_registered extends StatefulWidget{
  @override
  matching_court_registered_state createState() => matching_court_registered_state();
}

class matching_court_registered_state extends State<matching_court_registered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
         child: SingleChildScrollView(
            child: Container(
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
                        MaterialPageRoute(builder: (context) => court_register())
                    );
                  },
                  child: Text(
                      '예약 코트 등록하기',
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
            ),
          )
    );
  }
}