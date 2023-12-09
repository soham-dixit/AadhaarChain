import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/neumorphic_textfield.dart';

class EnrollmentForm extends StatefulWidget {
  const EnrollmentForm({Key? key});

  @override
  State<EnrollmentForm> createState() => _EnrollmentFormState();
}

class _EnrollmentFormState extends State<EnrollmentForm> {
  int selectedOption = 0;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeumorphicApp(
        home: NeumorphicBackground(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(),
                Column(
                  children: [
                    NeumorphicTextField(
                      hintText: 'Full Name',
                      iconData: Icons.account_circle_sharp,
                      controller: fullNameController,
                    ),
                    SizedBox(height: 20),
                    NeumorphicTextField(
                      hintText: 'Phone',
                      iconData: Icons.phone,
                      controller: phoneController,
                    ),
                    SizedBox(height: 20),
                    NeumorphicTextField(
                      hintText: 'Address',
                      iconData: Icons.home,
                      controller: addressController,
                    ),
                  ],
                ),
                // ... Other UI elements
              ],
            ),
          ),
        ),
      ),
    );
  }
}
