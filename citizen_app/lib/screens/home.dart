import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<String> loadMapStyle() async {
  return await rootBundle.loadString('assets/dark_map_style.json');
}

class _HomePageState extends State<HomePage> {
  late String _darkMapStyle;
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.top,
        depth: 2,
        textTheme: GoogleFonts.nunitoSansTextTheme(),
      ),
      home: Scaffold(
        appBar: NeumorphicAppBar(
          leading: Container(child: Icon(Icons.arrow_back, color: Colors.white,)),
          title: Text('AadharChain', style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(19.0760, 72.8777),
                zoom: 16.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              markers: _markers,
              circles: _circles,
            ),
          ],
        ),
      ),
    );
  }
}
