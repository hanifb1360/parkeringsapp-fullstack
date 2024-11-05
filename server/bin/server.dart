import 'dart:io';
import 'package:server/router.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:server/objectbox.g.dart';

void main(List<String> args) async {
  // Initialize ObjectBox store
  final store = Store(
    getObjectBoxModel(),
    directory: './objectbox',
  );

  // Register routes and start the server, passing the store to setupRouter
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addHandler(setupRouter(store).call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, InternetAddress.anyIPv4, port);
  print('Server listening on port ${server.port}');
}
