import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler((channel, protocol) {
    // channel.stream.listen(print);

    // Send a message back to the client.

    Timer.periodic(const Duration(seconds: 10), (timer) {
      print(DateTime.now());
      channel.sink.add('hi at ${DateTime.now()}');
    });
  });
  return handler(context);
}
