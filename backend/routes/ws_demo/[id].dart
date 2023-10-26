import 'dart:async';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final handler = webSocketHandler((channel, protocol) {
    print('$id connected');
    // channel.stream.listen(print);

    // Send a message back to the client.

    final timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      print('$id ${DateTime.now()}');
      channel.sink.add('hi at ${DateTime.now()}');
    });

    // Listen for messages from the client.
    channel.stream.listen(
      print,
      // The client has disconnected.
      onDone: () {
        print('$id disconnected');
        timer.cancel();
        channel.sink.close();
      },
    );
  });
  return handler(context);
}
