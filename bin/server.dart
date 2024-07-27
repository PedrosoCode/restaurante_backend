import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';
import 'package:restaurante_backend/handlers.dart';
import 'package:restaurante_backend/db.dart';

void main() async {
  await Database().connect();

  // Testar a conexão com o banco de dados e listar as tabelas
  try {
    var connection = Database().connection;
    var result = await connection.query(
        'SELECT table_name FROM information_schema.tables WHERE table_schema=\'public\'');
    print('Tables in the database: ${result.map((row) => row[0]).toList()}');
  } catch (e) {
    print('Database connection error: $e');
    return;
  }

  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(Handlers().router);

  var server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('Server running on localhost:${server.port}');
}
