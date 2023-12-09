import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Updation extends StatefulWidget {
  const Updation({Key? key}) : super(key: key);

  @override
  State<Updation> createState() => _UpdationState();
}

class _UpdationState extends State<Updation> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController timeController = TextEditingController();
  TimeOfDay? selectedTime;

  void showSnackbar() {
    Get.snackbar(
      'Invalid Time',
      'Please choose a time between 10 AM to 7 PM',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      darkTheme: const NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: NeumorphicAppBar(
            title: const Text(
              'AadhaarChain',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF3E3E3E),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 50.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/aadhaar.svg',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: const Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add your GoogleMap widget here if needed

              // Time Picker
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: NeumorphicTextField(
                    controller: timeController,
                    hintText: 'Appointment Time',
                    onTap: () async {
                      selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        // Check if selected time is between 10 AM and 7 PM
                        if (selectedTime!.hour < 10 ||
                            selectedTime!.hour >= 19) {
                          showSnackbar();
                        } else {
                          // Handle the selected time
                          print(
                              'Selected time: ${selectedTime!.format(context)}');
                          timeController.text =
                              selectedTime!.format(context).toString();
                        }
                      }
                    },
                    readOnly: true,
                    icon: Icons.access_time,
                  ),
                ),
              ),

              // Submit Button
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: NeumorphicButton(
                    onPressed: () {
                      Get.offNamed('');
                    },
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(12)),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 34, vertical: 12),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NeumorphicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final VoidCallback? onTap; // Add this line for onTap

  NeumorphicTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onTap, // Add this line for onTap
    bool readOnly = false, // Remove readOnly parameter if not needed
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        depth: 3,
        intensity: 0.5,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: onTap == null, // Set readOnly based on the presence of onTap
        onTap: onTap,
      ),
    );
  }
}
