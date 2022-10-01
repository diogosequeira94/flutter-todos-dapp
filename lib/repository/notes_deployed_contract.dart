import 'package:web3dart/web3dart.dart';

class NotesDeployedContract {
  final DeployedContract deployedContract;
  late ContractFunction createNote;
  late ContractFunction deleteNote;
  late ContractFunction notes;
  late ContractFunction noteCount;

  NotesDeployedContract(this.deployedContract){
    initFunctions();
  }
  Future<void> initFunctions() async {
    createNote = deployedContract.function('createNote');
    deleteNote = deployedContract.function('deleteNote');
    notes = deployedContract.function('notes');
    noteCount = deployedContract.function('noteCount');
  }
}
