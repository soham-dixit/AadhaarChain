import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

String contractAddress = '0x3cdEBf6A1c4E4294f3EEC38536493B4Baa2EB1B4';

Future<DeployedContract> loadContract(Web3Client ethClient) async {
  String abi = await rootBundle.loadString('assets/abi.json');
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'SimpleStorage'),
    EthereumAddress.fromHex(contractAddress),
  );
  return contract;
}

Future<String> sendTransaction(
    String funcName,
    List<dynamic> args,
    Web3Client ethClient,
    String privateKey,
    ) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract(ethClient);
  final ethFunction = contract.function(funcName);
  final result = await ethClient.sendTransaction(
    credentials,
    Transaction.callContract(
      contract: contract,
      function: ethFunction,
      parameters: args,
    ),
    chainId: null,
    fetchChainIdFromNetworkId: true,
  );
  return result;
}

Future<List<dynamic>> callFunction(
    String func,
    List<dynamic> args,
    Web3Client ethClient,
    ) async {
  final contract = await loadContract(ethClient);
  final ethFunction = contract.function(func);
  final result = await ethClient.call(
    contract: contract,
    function: ethFunction,
    params: args,
  );
  return result;
}

Future<List<dynamic>> getData(Web3Client ethClient) async {
  List<dynamic> result = await callFunction('getData', [], ethClient);
  return result;
}
