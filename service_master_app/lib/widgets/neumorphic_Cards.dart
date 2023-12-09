import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

class NeumorphicCards extends StatefulWidget {
  final name, time, index;

  const NeumorphicCards({super.key, this.name, this.time, this.index});

  @override
  State<NeumorphicCards> createState() => _NeumorphicCardsState();
}

class _NeumorphicCardsState extends State<NeumorphicCards> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(7),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.1),
            offset: Offset(-6.0, -6.0),
            blurRadius: 16.0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            offset: Offset(6.0, 6.0),
            blurRadius: 16.0,
          ),
        ],
        color: Color(0xFF292D32),
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: NeumorphicText(
                  widget.index,
                  style: const NeumorphicStyle(
                    depth: 3,
                    color: Color(0xFFFFD700),
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 26,
                    fontFamily: GoogleFonts.nunitoSans().fontFamily,
                  ),
                ),
              ),
              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  NeumorphicText(
                    widget.name,
                    style: const NeumorphicStyle(
                      depth: 2,
                      color: Colors.white,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 18,
                      fontFamily: GoogleFonts.nunitoSans().fontFamily,
                    ),
                  ),
                  SizedBox(height: 5),
                  NeumorphicText(
                    widget.time,
                    style: const NeumorphicStyle(
                      depth: 2,
                      color: Colors.white,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 13,
                      fontFamily: GoogleFonts.nunitoSans().fontFamily,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 8,
            right: 8,
            bottom: 0,
            child: Container(
              height: 0.5, // Height of the bottom border
              decoration: BoxDecoration(
                color: Color(0xFFFFD700), // Golden color for the bottom border
                borderRadius: BorderRadius.circular(100), // Circular edges
                shape: BoxShape.rectangle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
