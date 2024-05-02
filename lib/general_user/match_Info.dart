import 'package:flutter/material.dart';
import 'package:tennis_login/general_user/match_court_registered.dart';
import 'package:tennis_login/general_user/match_court_Notregistered.dart';

class matching_Info extends StatefulWidget{
  @override
  matching_Info_state createState() => matching_Info_state();
}

class matching_Info_state extends State<matching_Info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('매치 정보 입력',
            style: TextStyle(
              color: Color(0xFF222222),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w700,
              height: 0,
              letterSpacing: -0.14,
            ),
          ),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => matching_court_registered()),
                );
              },
              child: Text('예약함'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => matching_court_Notregistered()),
                );
              },
              child: Text('예약안함'),
            ),
          ],
        )
    );
  }
}