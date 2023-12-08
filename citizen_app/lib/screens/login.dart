import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_app/widgets/neumorphic_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeumorphicApp(
        darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.top,
          depth: 2,
          textTheme: GoogleFonts.nunitoSansTextTheme(),
        ),
        home: NeumorphicBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(),
                Column(
                  children: [
                    NeumorphicTextField(hintText: 'Email', iconData: Icons.email),
                    SizedBox(height: 20,),
                    NeumorphicTextField(hintText: 'Password', iconData: Icons.password),
                  ],
                ),
                NeumorphicButton(
                  onPressed: () {
                    Get.to('/');
                  },
                  child: Text(
                    '            Login            ',
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ),
          /*child: Center(
            child: NeumorphicButton(
              onPressed: () {},
              child: Text(
                  'Click Me',
                  style: TextStyle(
                    color: Colors.white
                  ),
              ),
            ),
          ),*/
        ),
      ),
    );
  }
}
