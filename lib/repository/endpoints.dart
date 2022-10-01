import 'package:meta/meta.dart';
import 'dart:io';

@immutable
class Endpoints {
  /// Remote Procedure Call [RPC Server] Ganash
  static String rpcUrl() => Platform.isAndroid ? 'http://10.0.2.2:7545' : 'http://127.0.0.1:7545';

  /// WebSocket Url
  static String wsUrl() => Platform.isAndroid ? 'http://10.0.2.2:7545' : 'ws://127.0.0.1:7545';

  /// Never use private keys in production, use walletconnect + metamask instead
  static String mockPrivateGanacheKey() =>
      'b8cf2cb2a5f2c366f7a41222dd3d77e3e3e80ad86225ee98db3c59a584934564';
}
