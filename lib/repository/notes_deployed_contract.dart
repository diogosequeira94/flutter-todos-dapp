import 'package:web3dart/web3dart.dart';

class NotesDeployedContract {
  late DeployedContract deployedContract;
  late ContractFunction createNote;
  late ContractFunction deleteNote;
  late ContractFunction notes;
  late ContractFunction noteCount;

  Future<void> initContract(ContractAbi contractAbiCode, EthereumAddress contractAddress) async {
    deployedContract = DeployedContract(contractAbiCode, contractAddress);
    createNote = deployedContract.function('createNote');
    deleteNote = deployedContract.function('deleteNote');
    notes = deployedContract.function('notes');
    noteCount = deployedContract.function('noteCount');
  }
}
