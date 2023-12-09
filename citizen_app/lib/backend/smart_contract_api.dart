import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';

String _contractAddress = '0x2f3322BBe122Fc4f89fdd6272e791a6F88eC72ba';

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = _contractAddress;
  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Aadhar1'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}
Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
      ),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
}

