import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

import '../backend/smart_contract_api.dart';

class UsingSmartContract extends StatefulWidget {
  const UsingSmartContract({super.key});

  @override
  State<UsingSmartContract> createState() => _UsingSmartContractState();
}

class _UsingSmartContractState extends State<UsingSmartContract> {
  Web3Client? ethClient;

  @override
  void initState() {
    super.initState();
    initializeWeb3Client();
  }

  Future<void> initializeWeb3Client() async {
    // Replace with your Ethereum node URL
    String rpcUrl = 'https://sepolia-rpc.scroll.io';

    ethClient = Web3Client(rpcUrl, Client());
  }

  Future<void> setData() async {
    // Replace with your private key
    String privateKey = '0x88DE3Ad5b5AcbC8b766524D837206170e6f629d2';

    if (ethClient != null) {
      BigInt valueToSend = BigInt.from(99); // Convert a regular int to BigInt
      await sendTransaction('setData', [valueToSend], ethClient!, privateKey);

      // Update the UI or perform other actions after setting data
    }
  }

  Future<void> getData() async {
    if (ethClient != null) {
      List<dynamic> data = await callFunction('getData', [], ethClient!);
      BigInt retrievedValue = data[0] as BigInt; // Assuming the value is returned as the first element in the result list
      // Update the UI or perform other actions with the retrieved data
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Contract Interaction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setData();
              },
              child: Text('Set Data'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getData();
              },
              child: Text('Get Data'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (ethClient != null) {
      ethClient!.dispose();
    }
    super.dispose();
  }
}
