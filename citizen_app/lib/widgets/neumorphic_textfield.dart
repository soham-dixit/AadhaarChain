import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NeumorphicTextField extends StatefulWidget {
  final String hintText;
  final IconData iconData;

  const NeumorphicTextField({super.key, required this.hintText, required this.iconData});

  @override
  State<NeumorphicTextField> createState() => _NeumorphicTextFieldState();
}

class _NeumorphicTextFieldState extends State<NeumorphicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        gradient: LinearGradient(
          colors: [Colors.grey, Colors.grey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.4],
          tileMode: TileMode.clamp,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
      child: TextField(
        expands: false,
        style: GoogleFonts.nunitoSans(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(12.0),
          prefixIcon: Icon(
            widget.iconData,
            color: Colors.black54,
          ),
          hintText: widget.hintText,
          hintStyle: GoogleFonts.nunitoSans(color: Colors.black87),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
