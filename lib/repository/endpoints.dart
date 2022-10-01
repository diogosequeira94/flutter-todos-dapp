import 'package:meta/meta.dart';

@immutable
class Endpoints {
  /// Remote Procedure Call [RPC Server] Ganash
  static String rpcUrl() => 'http://127.0.0.1:7545';

  /// RPC Android EP
  static String rpcUrlAndroid() => 'http://10.0.2.2:7545';

  /// WebSocket Url
  static String wsUrl() => 'ws://127.0.0.1:7545';

  /// WebSocket Android EP
  static String wsUrlAndroid() => 'http://10.0.2.2:7545';

  /// Never use private keys in production, use walletconnect + metamask instead
  static String mockPrivateGanashKey() =>
      'b8cf2cb2a5f2c366f7a41222dd3d77e3e3e80ad86225ee98db3c59a584934564';
}
