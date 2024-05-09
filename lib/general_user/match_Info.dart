import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tennis_login/screens/maps/loacation_map.dart';

class MatchInfo extends StatefulWidget {
  const MatchInfo({super.key});

  @override
  State<MatchInfo> createState() => _MatchInfoState();
}

class _MatchInfoState extends State<MatchInfo> with TickerProviderStateMixin {
  // tabbar 사용
  late TabController tabcontroller = TabController(
    vsync: this,
    length: 2,
    initialIndex: 0,
  );

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  // 코트 선택 toggle button
  final CourtSelected = [true, false, false];

  // 단복식 여부 toggle button
  final isSingles = [true, false];

  // 즐겜 or 빡겜 여부 toggle button
  final objective = [true, false];

  // 저장할 변수들
  bool _isFocused = false;
  DateTime? Reserved_Date;
  TimeOfDay? Start_Time;
  TimeOfDay? End_Time;
  String money = '';
  String message = '';
  double distance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '매칭 정보 입력하기',
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
      body: Column(
        children: [
          Align(
            alignment: Alignment(0, 0),
            child: TabBar(
              controller: tabcontroller,
              padding: EdgeInsets.all(4),
              tabs: [
                Tab(text: '코트 예약 했어요!'),
                Tab(text: '코트 예약 안 했어요!'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: tabcontroller,
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.13,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                              child: Text(
                                '예약 코트',
                                textAlign: TextAlign.center,
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
                            Container(
                              child: Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(315, 30),
                                      backgroundColor: Color(0xFF464EFF),
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFF464EFF)),
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  onPressed: () {
                                    // Todo : 등록화면 만들기
                                  },
                                  child: Text('예약 코트 등록하기',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                        letterSpacing: -0.10,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.13,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
                              child: Text(
                                '예약 시간',
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
                              child: Row(
                                children: [
                                  // 예약 일자
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: InkWell(
                                      child: Container(
                                        width: 105,
                                        height: 25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.calendar_today,
                                                size: 15),
                                            SizedBox(width: 16),
                                            Flexible(
                                              child: Text(
                                                Reserved_Date != null
                                                    ? DateFormat('yyyy-MM-dd')
                                                        .format(Reserved_Date!)
                                                    : '날짜',
                                                style: TextStyle(
                                                  color: Color(0xFF919191),
                                                  fontSize: 8,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final DateTime? picked =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2025),
                                        );
                                        if (picked != null &&
                                            picked != Reserved_Date) {
                                          setState(() {
                                            Reserved_Date = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  // 예약 시작 시간
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: InkWell(
                                      child: Container(
                                        width: 85,
                                        height: 25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.alarm, size: 15),
                                            SizedBox(width: 16),
                                            Flexible(
                                              child: Text(
                                                Start_Time == null
                                                    ? '시작 시간'
                                                    : '${Start_Time!.format(context)}',
                                                style: TextStyle(
                                                  color: Color(0xFF919191),
                                                  fontSize: 8,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final TimeOfDay? picked =
                                            await showTimePicker(
                                          context: context,
                                          initialTime:
                                              Start_Time ?? TimeOfDay.now(),
                                        );
                                        if (picked != null &&
                                            picked != Start_Time) {
                                          setState(() {
                                            Start_Time = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    '~',
                                    style: TextStyle(
                                      color: Color(0xFF4E4E4E),
                                      fontSize: 10,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                      letterSpacing: -0.10,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: InkWell(
                                      child: Container(
                                        width: 85,
                                        height: 25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(Icons.alarm, size: 15),
                                            SizedBox(width: 16),
                                            Flexible(
                                              child: Text(
                                                Start_Time == null
                                                    ? '종료 시간'
                                                    : '${Start_Time!.format(context)}',
                                                style: TextStyle(
                                                  color: Color(0xFF919191),
                                                  fontSize: 8,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      onTap: () async {
                                        final TimeOfDay? picked =
                                            await showTimePicker(
                                          context: context,
                                          initialTime:
                                              End_Time ?? TimeOfDay.now(),
                                        );
                                        if (picked != null &&
                                            picked != End_Time) {
                                          setState(() {
                                            End_Time = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Text(
                                  '코트 대여 비용',
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
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      60, 10, 10, 10),
                                  child: Container(
                                      width: 120,
                                      height: 30,
                                      child: TextFormField(
                                        style: TextStyle(
                                          color: Color(0xFF646464),
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: 1.0,
                                          letterSpacing: -0.10,
                                        ),
                                        textAlignVertical:
                                            TextAlignVertical(y: 1.0),
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
                                        controller:
                                            TextEditingController(text: money),
                                        onChanged: (value) {
                                          double.parse(money);
                                          money = value;
                                        },
                                        decoration: InputDecoration(
                                            // 입력창 배경은 회색, 선택할 때 흰색
                                            filled: true,
                                            fillColor: _isFocused
                                                ? Colors.white
                                                : Colors.white,
                                            hintText: '전체 금액',
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Color(0xFFD3D3D3))),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.black)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    borderSide: BorderSide(
                                                        color: Colors.red))),
                                      )),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: Text(
                                  '원',
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
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: Row(children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Text(
                              '경기 코트',
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
                          Container(
                            width: 230,
                            height: 25,
                            alignment: Alignment.centerRight,
                            child: ToggleButtons(
                              constraints: BoxConstraints(
                                minHeight: 20,
                                minWidth: 50,
                              ),
                              children: [
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('하드코트',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.10,
                                        ))),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('플레이코트',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.10,
                                        ))),
                                Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    child: Text('잔디코트',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.10,
                                        ))),
                              ],
                              isSelected: CourtSelected,
                              selectedBorderColor: Color(0xFF464EFF),
                              fillColor: Color(0xFF464EFF),
                              selectedColor: Colors.white,
                              borderRadius: BorderRadius.circular(3),
                              onPressed: (index) {
                                setState(() {
                                  for (int buttonIndex = 0;
                                      buttonIndex < CourtSelected.length;
                                      buttonIndex++) {
                                    if (buttonIndex == index) {
                                      CourtSelected[buttonIndex] = true;
                                    } else {
                                      CourtSelected[buttonIndex] = false;
                                    }
                                  }
                                });
                              },
                            ),
                          )
                        ]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Text(
                                '경기 유형',
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
                            Container(
                              alignment: Alignment.center,
                              child: ToggleButtons(
                                constraints: BoxConstraints(
                                  minHeight: 20,
                                  minWidth: 120,
                                ),
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('단식',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.10,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('복식',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.10,
                                          ))),
                                ],
                                isSelected: isSingles,
                                selectedBorderColor: Color(0xFF464EFF),
                                fillColor: Color(0xFF464EFF),
                                selectedColor: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                onPressed: (index) {
                                  setState(() {
                                    if (index == 0) {
                                      isSingles[0] = true;
                                      isSingles[1] = false;
                                    } else {
                                      isSingles[0] = false;
                                      isSingles[1] = true;
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.07,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                              child: Text(
                                '경기 목적',
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
                            Container(
                              alignment: Alignment.center,
                              child: ToggleButtons(
                                constraints: BoxConstraints(
                                  minHeight: 20,
                                  minWidth: 120,
                                ),
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('부담없이',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.10,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      child: Text('진지하게',
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.10,
                                          ))),
                                ],
                                isSelected: objective,
                                selectedBorderColor: Color(0xFF464EFF),
                                fillColor: Color(0xFF464EFF),
                                selectedColor: Colors.white,
                                borderRadius: BorderRadius.circular(3),
                                onPressed: (index) {
                                  setState(() {
                                    if (index == 0) {
                                      objective[0] = true;
                                      objective[1] = false;
                                    } else {
                                      objective[0] = false;
                                      objective[1] = true;
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.13,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 10),
                              child: Text(
                                '한 줄 메세지',
                                textAlign: TextAlign.center,
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
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 0, 0, 3),
                              child: Container(
                                width: 300,
                                height: 30,
                                child: TextFormField(
                                  textAlignVertical: TextAlignVertical(y: 1.0),
                                  style: TextStyle(
                                    color: Color(0xFF646464),
                                    fontSize: 10,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                    letterSpacing: -0.10,
                                  ),
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
                                  controller:
                                      TextEditingController(text: message),
                                  onChanged: (value) {
                                    message = value;
                                  },
                                  decoration: InputDecoration(
                                      // 입력창 배경은 회색, 선택할 때 흰색
                                      filled: true,
                                      fillColor: _isFocused
                                          ? Colors.white
                                          : Color(0xFFEDEDED),
                                      hintText: '상대 플레이어에게 보여주는 멋진 소개글을 적어주세요!',
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                              color: Color(0xFFEDEDED))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.black)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide:
                                              BorderSide(color: Colors.red))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size(315, 30),
                              backgroundColor: Color(0xFF464EFF),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1, color: Color(0xFF464EFF)),
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {},
                          child: Text('매칭 정보 저장하기',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w700,
                                height: 0,
                                letterSpacing: -0.10,
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text('나의 위치',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 10,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.0,
                                          letterSpacing: -0.10,
                                        )),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 315,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xFF464EFF),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF464EFF)),
                                                borderRadius:
                                                    BorderRadius.circular(20))),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LocationMap()),
                                          );
                                        },
                                        child: Row(children: [
                                          Icon(
                                            Icons.gps_fixed,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            '내 동네 인증하기',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w700,
                                              height: 0,
                                              letterSpacing: -0.10,
                                            ),
                                          ),
                                        ])),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.info_outline,
                                          color: Color(0xFF4E4E4E),
                                          size: 10,
                                        ),
                                        Text(
                                          '서비스 이용을 위해 동네 인증을 꼭 진행해주세요',
                                          style: TextStyle(
                                            color: Color(0xFF4E4E4E),
                                            fontSize: 8,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: -0.08,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Text(
                                        '희망 시간',
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
                                    InkWell(
                                      child: ListView(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 10, 20, 10),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 25,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFD3D3D3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              vertical: -4),
                                                      leading: Icon(
                                                        Icons.calendar_today,
                                                        size: 15,
                                                      ),
                                                      title: Text(
                                                        '날짜',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF919191),
                                                          fontSize: 8,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: -0.08,
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        final DateTime? picked =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime.now(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 25,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFD3D3D3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              vertical: -4),
                                                      leading: Icon(
                                                        Icons.calendar_today,
                                                        size: 15,
                                                      ),
                                                      title: Text(
                                                        '날짜',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF919191),
                                                          fontSize: 8,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: -0.08,
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        final DateTime? picked =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime.now(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  '~',
                                                  style: TextStyle(
                                                    color: Color(0xFF4E4E4E),
                                                    fontSize: 10,
                                                    fontFamily: 'Roboto',
                                                    fontWeight: FontWeight.w500,
                                                    height: 0,
                                                    letterSpacing: -0.10,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 10, 0),
                                                  child: Container(
                                                    width: 100,
                                                    height: 25,
                                                    decoration: ShapeDecoration(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            width: 1,
                                                            color: Color(
                                                                0xFFD3D3D3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: ListTile(
                                                      dense: true,
                                                      visualDensity:
                                                          VisualDensity(
                                                              vertical: -4),
                                                      leading: Icon(
                                                        Icons.calendar_today,
                                                        size: 15,
                                                      ),
                                                      title: Text(
                                                        '날짜',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFF919191),
                                                          fontSize: 8,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          letterSpacing: -0.08,
                                                        ),
                                                      ),
                                                      onTap: () async {
                                                        final DateTime? picked =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime.now(),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                // todo : 시작시간, 종료시간 list 만들기
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Align(
                                      alignment: AlignmentDirectional(0, 0),
                                      child: IconButton(
                                        color: Color(0xFF9296FF),
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.07,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 0),
                                    child: Text(
                                      '경기 유형',
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
                                  // todo : togglebutton
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.07,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 20, 0),
                                    child: Text(
                                      '경기 목적',
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
                                  // todo : toggle button
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1, -1),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 20, 0, 0),
                                      child: Text('최대 이동 가능 거리',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w600,
                                            height: 1.0,
                                            letterSpacing: -0.10,
                                          )),
                                    ),
                                  ),
                                  Slider(
                                    activeColor: Color(0xFF464EFF),
                                    inactiveColor: Color(0xFFEDEDED),
                                    min: 0,
                                    max: 100,
                                    divisions: 10,
                                    value: distance,
                                    onChanged: (Value) {
                                      setState(() => distance = Value);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: 130,
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 0, 0),
                                    child: Text(
                                      '비선호 코트 등록',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                        letterSpacing: -0.10,
                                      ),
                                    ),
                                  ),
                                  ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    children: [],
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: IconButton(
                                      color: Color(0xFF9296FF),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.13,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 0, 0, 0),
                                    child: Text(
                                      '한 줄 메세지',
                                      textAlign: TextAlign.center,
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
                                  TextFormField(
                                    style: TextStyle(
                                      color: Color(0xFF646464),
                                      fontSize: 10,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w400,
                                      height: 1.0,
                                      letterSpacing: -0.10,
                                    ),
                                    textAlignVertical:
                                        TextAlignVertical(y: 1.0),
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
                                    controller:
                                        TextEditingController(text: message),
                                    onChanged: (value) {
                                      message = value;
                                    },
                                    decoration: InputDecoration(
                                        // 입력창 배경은 회색, 선택할 때 흰색
                                        filled: true,
                                        fillColor: _isFocused
                                            ? Colors.white
                                            : Color(0xFFEDEDED),
                                        hintText:
                                            '상대 플레이어에게 보여주는 멋진 소개글을 적어주세요!',
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Color(0xFFEDEDED))),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide:
                                                BorderSide(color: Colors.red))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 315,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF464EFF),
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFF464EFF)),
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {},
                              child: Text('매칭 정보 저장하기',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                    letterSpacing: -0.10,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
