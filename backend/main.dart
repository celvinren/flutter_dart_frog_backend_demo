// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';


Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  final apiUrl = Platform.environment['API_URL'];
  final apiAccessKey = Platform.environment['API_ACCESS_KEY'];
  print(apiUrl);
  print(apiAccessKey);

  return serve(handler, ip, port);
}
