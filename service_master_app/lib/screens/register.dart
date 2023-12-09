import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location/location.dart';
import 'package:service_master_app/widgets/neumorphic_textfield.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late LocationData _currentLocation;

  Future<void> getLatiLongi() async {
    Location location = Location();

    try {
      _currentLocation = await location.getLocation();
      print("Latitude: ${_currentLocation.latitude}");
      print("Longitude: ${_currentLocation.longitude}");
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatiLongi();
  }

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
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align to the start of the column
              children: [
                // SVG image above email text field with reduced margin
                Container(
                  margin: const EdgeInsets.only(
                      top: 150), // Adjust the top margin as needed
                  child: SvgPicture.asset(
                    'assets/aadhaar.svg', // Replace with your SVG image path
                    height: 100,
                    width: 100,
                  ),
                ),
                NeumorphicText(
                  'Service Master',
                  style: const NeumorphicStyle(
                    depth: 2, // Customize the depth as needed
                    color: Colors.white,
                  ),
                  textStyle: NeumorphicTextStyle(
                    fontSize: 20, // Customize the font size as needed
                    fontFamily: GoogleFonts.nunitoSans()
                        .fontFamily, // Replace with your desired font from google_fonts
                  ),
                ),
                const SizedBox(height: 80), // Reduced gap
                const Column(
                  children: [
                    NeumorphicTextField(
                      hintText: 'Name',
                      iconData: Icons.person,
                    ),
                    SizedBox(
                      height: 20, // Reduced gap
                    ),
                    NeumorphicTextField(
                      hintText: 'Email',
                      iconData: Icons.email,
                    ),
                    SizedBox(
                      height: 20, // Reduced gap
                    ),
                    NeumorphicTextField(
                      hintText: 'Password',
                      iconData: Icons.password,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100, // Reduced gap
                ),
                NeumorphicButton(
                  onPressed: () {
                    Get.offNamed('/home');
                  },
                  style: NeumorphicStyle(
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(
                            12)), // Adjust the border radius as needed
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 34,
                      vertical: 12), // Adjust the padding as needed
                  child: const Text(
                    'Regsiter',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50, // Adjust the gap as needed
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NeumorphicText(
                      'Already registered?',
                      style: const NeumorphicStyle(
                        depth: 2, // Customize the depth as needed
                        color: Colors.white,
                      ),
                      textStyle: NeumorphicTextStyle(
                        fontSize: 16, // Customize the font size as needed
                        fontFamily: GoogleFonts.nunitoSans()
                            .fontFamily, // Replace with your desired font from google_fonts
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed('/login');
                      },
                      child: NeumorphicText(
                        ' Login now',
                        style: const NeumorphicStyle(
                          depth: 2, // Customize the depth as needed
                          color: Colors.white,
                        ),
                        textStyle: NeumorphicTextStyle(
                          fontSize: 16, // Customize the font size as needed
                          fontFamily: GoogleFonts.nunitoSans()
                              .fontFamily, // Replace with your desired font from google_fonts
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
