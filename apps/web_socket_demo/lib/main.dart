import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  WebSocketChannel? wsChannel;
  Uri? uri;
  @override
  void initState() {
    super.initState();

    ///Web
    // final uri = Uri.parse('ws://127.0.0.1:8080/ws_demo/ws');

    ///GenyMotion Emulator
    uri = Uri.parse('ws://10.0.3.2:8080/ws_demo/105');

    ///Android Emulator
    // final uri = Uri.parse('ws://10.0.2.2:8080/ws_demo/ws');
    wsChannel = WebSocketChannel.connect(uri!);
  }

  @override
  void dispose() {
    wsChannel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              builder: (ct, data) {
                return Column(
                  children: [
                    Center(
                      child: Text(
                        (data.data as String?) ?? '',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        wsChannel?.sink.close();
                        wsChannel = null;
                      },
                      child: const Text('Disconnect'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        wsChannel ??= WebSocketChannel.connect(uri!);
                      },
                      child: const Text('Reconnect'),
                    ),
                  ],
                );
              },
              stream: wsChannel!.stream,
            ),
          ],
        ),
      ),
    );
  }
}
