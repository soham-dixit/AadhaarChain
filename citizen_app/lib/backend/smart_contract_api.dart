import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

String contractAddress = '0x1D040A368b753D646Ed65B77e88C28f6f5eD4A39';

Future<DeployedContract> loadContract(Web3Client ethClient) async {
  String abi = await rootBundle.loadString('assets/abi.json');
  final contract = DeployedContract(
    ContractAbi.fromJson(abi, 'Aadhar1'),
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

// Register a user using the `registerUser` function in the smart contract
Future<bool> registerUser(
    String name,
    String email,
    String password,
    String role,
    Web3Client ethClient,
    String privateKey,
    ) async {
  DeployedContract contract = await loadContract(ethClient);
  final function = contract.function('registerUser');
  final result = await ethClient.sendTransaction(
    EthPrivateKey.fromHex(privateKey),
    Transaction.callContract(
      contract: contract,
      function: function,
      parameters: [
        name,
        email,
        password,
        role,
      ],
    ),
    chainId: null,
    fetchChainIdFromNetworkId: true,
  );
  // Handle result and return success/failure
  // Depending on your contract, you might need to decode the result
  // and handle any errors or specific return values here
  return result != null; // Return true if the transaction was successful
}

// Login a user using the `loginUser` function in the smart contract
Future<int?> loginUser(
    String email,
    String password,
    Web3Client ethClient,
    ) async {
  DeployedContract contract = await loadContract(ethClient);
  final function = contract.function('loginUser');
  final result = await ethClient.call(
    contract: contract,
    function: function,
    params: [
      email,
      password,
    ],
  );
  // Decode and return the user ID or status here
  // Convert the result to the required format
  return int.tryParse(result.toString());
}

// Implement similar functions for other smart contract methods
// You can follow a similar structure for other contract functions such as `registerOperator`, `loginOperator`, etc.
