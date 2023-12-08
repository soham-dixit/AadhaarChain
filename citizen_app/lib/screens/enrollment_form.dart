import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/neumorphic_textfield.dart';

class EnrollmentForm extends StatefulWidget {
  const EnrollmentForm({super.key});

  @override
  State<EnrollmentForm> createState() => _EnrollmentFormState();
}

class _EnrollmentFormState extends State<EnrollmentForm> {

  int selectedOption = 0;

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
                    NeumorphicTextField(hintText: 'Full Name', iconData: Icons.account_circle_sharp),
                    SizedBox(height: 20,),
                    NeumorphicTextField(hintText: 'Phone', iconData: Icons.phone),
                    SizedBox(height: 20,),
                    NeumorphicTextField(hintText: 'Address', iconData: Icons.home),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: const Text('Cash on Service'),
                      leading: Radio(
                        value: 1,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                            print("Button value: $value");
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Online Payment'),
                      leading: Radio(
                        value: 2,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NeumorphicButton(
                      onPressed: () {
                        Get.offNamed('/home');
                      },
                      child: Text(
                        '         Cancel         ',
                        style: GoogleFonts.nunitoSans(color: Colors.white),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {
                        Get.offNamed('/home');
                      },
                      child: Text(
                        '         Book         ',
                        style: GoogleFonts.nunitoSans(color: Colors.white),
                      ),
                    ),
                  ],
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
