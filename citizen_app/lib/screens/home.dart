import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:web3dart/web3dart.dart';

class Operator {
  final int id;
  final String name;
  final String email;
  final String password;
  final String latitude;
  final String longitude;
  final String role;
  final String addr;

  Operator({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.latitude,
    required this.longitude,
    required this.role,
    required this.addr,
  });

  factory Operator.fromJson(Map<String, dynamic> json) {
    return Operator(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      latitude: json['latitude'] as String,
      longitude: json['longitude'] as String,
      role: json['role'] as String,
      addr: json['addr'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'latitude': latitude,
      'longitude': longitude,
      'role': role,
      'addr': addr,
    };
  }
}


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Location currentLocation = Location();
  bool shouldUpdateCamera = true;

  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  late BitmapDescriptor mapMarker, femaleMarker, maleMarker, transgenderMarker;

  // Sample data for the list
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
    setupWeb3();
    setState(() {
      getLocation();
      setCustomMarker();
    });
    getAllOperators();
  }

  Future<List<Operator>> getAllOperators() async {
    List<Operator> operators = [];
    try {
      String abi = await rootBundle.loadString('assets/abi.json');
      DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, "Aadhar1"),
        EthereumAddress.fromHex(contractAddress),
      );

      List<dynamic> result = await client.call(
        contract: contract,
        function: contract.function('getAllOperators'),
        params: [],
      );

      // Process the result obtained from the contract call
      if(result!=null) {
        itemList.removeAt(0);
      }
      for (var item in result) {

        for(var val in item) {
          itemList.add(val[1]);
        }
      }
     } catch (e) {
      print('Error fetching operators: $e');
    }
    return operators;
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void getLocation() async {
    var location = await currentLocation.getLocation();
    currentLocation.onLocationChanged.listen((LocationData loc) {
      if (shouldUpdateCamera) {
        _controller?.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(loc.latitude!, loc.longitude!),
            zoom: 13,
          ),
        ));
        shouldUpdateCamera = false; // Set the flag to false after updating once
      }
      print('location updated');
      print(loc.latitude);
      print(loc.longitude);

      setState(() {
        _markers.addAll([
          Marker(
            markerId: const MarkerId('User Location'),
            position: LatLng(loc.latitude!, loc.longitude!),
            // Use the default marker
            icon: BitmapDescriptor.defaultMarker,
          ),
        ]);
        _circles.add(
          Circle(
            circleId: const CircleId("user circle"),
            center: LatLng(loc.latitude ?? 0.0, loc.longitude ?? 0.0),
            radius: 3000,
            fillColor: Colors.blue.shade100.withOpacity(0.5),
            strokeColor: Colors.blue.withAlpha(70),
            strokeWidth: 2,
          ),
        );
      });
    });
  }

  void setCustomMarker() async {
    mapMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/user-marker.png');
    femaleMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/Female-Operator.png');
    maleMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/Male-Operator.png');
    transgenderMarker = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), 'assets/Others-Operator.png');
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
          // Adjust the height as needed
          preferredSize: const Size.fromHeight(60.0),
          child: NeumorphicAppBar(
            title: const Text(
              'AadhaarChain',
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white, // Set the desired color for the menu icon
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
                    maxHeight: 50.0, // Adjust the maxHeight as needed
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
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
              initialCameraPosition: const CameraPosition(
                target: LatLng(19.0760, 72.8777),
                zoom: 16.0,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
              },
              markers: _markers,
              circles: _circles,
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: NeumorphicButton(
                onPressed: () {
                  _showBottomSheet();
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(30.0),
                  ),
                  depth: 8, // Adjust the depth as needed
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Center(
                  child: Text(
                    'Show Service Masters',
                    style: GoogleFonts.nunitoSans(color: Colors.amber),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      elevation: 0.0, // Set elevation to 0.0 to avoid shadow
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 300.0,
              decoration: const BoxDecoration(
                color: Color(0xFF3E3E3E),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
              ),
              child: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Text(
                              (index+1).toString(),
                              style: GoogleFonts.nunitoSans(color: Colors.amber, fontSize: 18),
                            ),
                            SizedBox(width: 30,),
                            Text(
                              itemList[index],
                              style: GoogleFonts.nunitoSans(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                        onTap: () {
                          _showAlertDialog();
                        },
                      ),
                      Container(height: 0.3, color: Colors.amber,)
                    ],
                  );
                },
              ),
            ),
            Container(width: 100, height: 3, color: Colors.grey,),
          ],
        );
      },
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF3E3E3E),
          title: const Text('Choose an option', style: TextStyle(color: Colors.white),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.to(
                  WebviewScaffold(
                    url:
                        "https://anon-aadhar.web.app/",
                    appBar: new AppBar(
                      title: new Text("Powered by anon aadhaar"),
                      backgroundColor:
                      Color(0xFF3E3E3E),
                  ),
                ));
              },
              child: const Text('Updation', style: TextStyle(color: Colors.amber),),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.toNamed("/enrollment_form");
              },
              child: const Text('Enrollment', style: TextStyle(color: Colors.amber),),
            ),
          ],
        );
      },
    );
  }
}
