import 'dart:io';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf/shelf.dart';
import 'package:restaurante_backend/handlers.dart';
import 'package:restaurante_backend/db.dart';

void main() async {
  await Database().connect();

  // Testar a conexão com o banco de dados
  try {
    var connection = Database().connection;
    var result = await connection.query('SELECT 1');
    print('Database connection test: ${result.first[0]}');
  } catch (e) {
    print('Database connection error: $e');
    return;
  }

  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(Handlers().router);

  var server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Server running on localhost:${server.port}');
}
