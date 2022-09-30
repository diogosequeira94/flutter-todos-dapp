import 'package:meta/meta.dart';

@immutable
class Endpoints {
  /// Remote Procedure Call [RPC Server] Ganash
  static String rpcUrl() => 'http://127.0.0.1:7545';

  /// WebSocket Url
  static String wsUrl() => 'ws://127.0.0.1:7545';

  /// Never use private keys in production, use walletconnect + metamask instead
  static String mockPrivateGanashKey() => 'loremipsum';
}
