import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:tennis_login/general_user/match_Info.dart';

class TennisMatchScreen extends StatefulWidget {
  const TennisMatchScreen({
    super.key,
  });

  @override
  _TennisMatchScreenState createState() => _TennisMatchScreenState();
}

class _TennisMatchScreenState extends State<TennisMatchScreen> {
  List<Container> cards = [
    Container(
      alignment: Alignment.center,
      child: const Text('1'),
      color: Colors.lightBlueAccent,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('2'),
      color: Colors.lightGreenAccent,
    ),
    Container(
      alignment: Alignment.center,
      child: const Text('3'),
      color: Colors.orangeAccent,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('앱바 영역'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MatchInfo()),
              );
            },
          ),
        ],
      ),
      body: Flexible(
        child: CardSwiper(
          cardsCount: cards.length,
          cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
              cards[index],
        ),
      ),
    );
  }
}
