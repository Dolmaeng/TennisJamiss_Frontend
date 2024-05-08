import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

String selectedTitle = 'Location Map Test';


class LocationMap extends StatefulWidget {
  const LocationMap({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<LocationMap> createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  late KakaoMapController mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? selectedTitle),
      ),
      body: KakaoMap(
        onMapTap: (latLng) {
          debugPrint('***** [JHC_DEBUG] ${latLng.toString()}');
        },
      ),
    );
  }
}
