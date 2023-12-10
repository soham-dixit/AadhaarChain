import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:service_master_app/widgets/neumorphic_Cards.dart';
import 'package:web3dart/web3dart.dart';

class Appointment {
  final String date;
  final String time;
  final String status;
  final String appointmentType;
  final int userId;
  final int operatorId;

  Appointment({
    required this.date,
    required this.time,
    required this.status,
    required this.appointmentType,
    required this.userId,
    required this.operatorId,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      date: json['date'] as String,
      time: json['time'] as String,
      status: json['status'] as String,
      appointmentType: json['appointmentType'] as String,
      userId: json['userId'] as int,
      operatorId: json['operatorId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'status': status,
      'appointmentType': appointmentType,
      'userId': userId,
      'operatorId': operatorId,
    };
  }
}


class Apointments extends StatefulWidget {
  const Apointments({super.key});

  @override
  State<Apointments> createState() => _ApointmentsState();
}

class _ApointmentsState extends State<Apointments> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> itemList = [
    'Nothing to see at the moment!',
  ];

  late Web3Client client;
  late EthPrivateKey credentials;

  final String contractAddress = "0x7Bdf1Af327b9BB9FbF89C8fd96fBa51EA556ab28";
  final String rpcUrl = "https://sepolia-rpc.scroll.io";

  Future<void> setupWeb3() async {
    client = Web3Client(rpcUrl, Client());
    credentials = EthPrivateKey.fromHex("35a011347e6bed879f9cb3555455be92dbab7bb8074a375097a35e11e12eeeea");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllOperators();
    setupWeb3();
  }

  void getAllOperators() async {
    try {
      String abi = await rootBundle.loadString('assets/abi.json');
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, "Aadhar1"),
        EthereumAddress.fromHex(contractAddress),
      );

      List<dynamic> result = await client.call(
        contract: contract,
        function: contract.function('getAllAppointments'),
        params: [BigInt.from(1)],
      );

      // Process the result obtained from the contract call
      itemList.removeAt(0);
          for (var item in result) {

        for(var val in item) {
          itemList.add(val[1]);
        }
      }

    } catch (e) {
      print('Error fetching operators: $e');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: AppBar(
          backgroundColor: Color(0xFF292929),
          title: const Text(
            'Current Appointments',
          ),
        ),
      ),
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
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Column(
              children: [
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: itemList.length - 1,
                    itemBuilder: (BuildContext context, int index) {
                      return itemList.length - 1 == 0 ? Center(
                        child: Text("Nothing to see here!"),
                      ) :NeumorphicCards(name: 'Slot booked for ' + '10:45', index: (index+1).toString(),);
                    },
                  ),
                ),
                Center(child: LottieBuilder.asset('assets/loading_anim.json', width: 100, height: 100,)),
                Center(
                  child: NeumorphicText(
                    'Looks like there is nothing beyond this point, check back later!',
                    style: const NeumorphicStyle(
                      depth: 2, // Customize the depth as needed
                      color: Colors.amber,
                    ),
                    textStyle: NeumorphicTextStyle(
                      fontSize: 20, // Customize the font size as needed
                      fontFamily: GoogleFonts.nunitoSans()
                          .fontFamily, // Replace with your desired font from google_fonts
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}

