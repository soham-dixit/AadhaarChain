import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:service_master_app/widgets/neumorphic_textfield.dart';
import 'package:web3dart/web3dart.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late LocationData _currentLocation;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  late Web3Client client;
  late EthPrivateKey credentials;

  final String contractAddress = "0x7Bdf1Af327b9BB9FbF89C8fd96fBa51EA556ab28";
  final String rpcUrl = "https://sepolia-rpc.scroll.io";

  Future<void> setupWeb3() async {
    client = Web3Client(rpcUrl, Client());
    credentials = EthPrivateKey.fromHex(
        "35a011347e6bed879f9cb3555455be92dbab7bb8074a375097a35e11e12eeeea");
  }

  Future<void> getLatiLongi() async {
    Location location = Location();

    try {
      _currentLocation = await location.getLocation();
      print("Latitude: ${_currentLocation.latitude}");
      print("Longitude: ${_currentLocation.longitude}");
      latitudeController.text = _currentLocation.latitude.toString();
      longitudeController.text = _currentLocation.longitude.toString();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<bool> registerOperator() async {
    try {
      String name = nameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      String role = "service_master"; // Define the role as needed

      String abi = await rootBundle.loadString('assets/abi.json');
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, "Aadhar1"),
        EthereumAddress.fromHex(contractAddress),
      );
      ContractFunction function = contract.function('registerOperator');

      // ABI encoding for the registerUser function
      List<dynamic> params = [
        name,
        email,
        password,
        latitudeController.toString(),
        longitudeController.toString(),
        role,
      ];

      final response = await client.sendTransaction(
          credentials,
          Transaction.callContract(
            contract: contract,
            function: function,
            parameters: params,
          ),
          chainId: null, //534351
          fetchChainIdFromNetworkId: true);

      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      e.printInfo();
      e.printError();
      e.toString();
      return false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLatiLongi();
    setupWeb3();
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
                  onPressed: () async {
                    bool registered = await registerOperator();
                    if (registered) {
                      Get.toNamed('/customer_list');
                    } else {
                      Get.snackbar("Error", "Unknown Exception!");
                    }
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
                    'Register',
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
