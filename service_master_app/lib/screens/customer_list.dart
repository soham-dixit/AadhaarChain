import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:service_master_app/widgets/neumorphic_Cards.dart';

import '../widgets/neumorphic_textfield.dart';

class Apointments extends StatefulWidget {
  const Apointments({super.key});

  @override
  State<Apointments> createState() => _ApointmentsState();
}

class _ApointmentsState extends State<Apointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        darkTheme: NeumorphicThemeData(
          baseColor: const Color(0xFF3E3E3E),
          lightSource: LightSource.top,
          depth: 2,
          textTheme: GoogleFonts.nunitoSansTextTheme(),
        ),
        home: NeumorphicBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return NeumorphicCards(name: 'Customer $index', time: 'Slot booked for ' + '10:45', index: (index+1).toString(),);
              },
            )
          ),
        ),
      ),
    );
  }
}
