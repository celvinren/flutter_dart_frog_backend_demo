import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  final apiUrl = Platform.environment['API_URL'];
  return Response(body: 'Welcome to Dart Frog! \n$apiUrl');
}
