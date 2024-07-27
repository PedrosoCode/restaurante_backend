import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/db.dart'; // Importação de pacote
import 'dart:convert';

class Handlers {
  Router get router {
    final router = Router();

    router.get('/pratos', (Request request) async {
      try {
        var results =
            await Database().connection.query('SELECT * FROM tb_cad_prato');
        var pratos = results
            .map((row) => {'id': row[0], 'nome': row[1], 'preco': row[2]})
            .toList();
        return Response.ok(jsonEncode(pratos),
            headers: {'Content-Type': 'application/json'});
      } catch (e) {
        print('Error fetching pratos: $e');
        return Response.internalServerError(body: 'Error fetching pratos');
      }
    });

    router.post('/adicionar_prato', (Request request) async {
      try {
        var params = request.url.queryParameters;
        var nome = params['nome'];
        var preco = params['preco'];
        await Database().connection.query(
          'INSERT INTO tb_cad_prato (nome, preco) VALUES (@nome, @preco)',
          substitutionValues: {'nome': nome, 'preco': preco},
        );
        return Response.ok('Prato adicionado');
      } catch (e) {
        print('Error adding prato: $e');
        return Response.internalServerError(body: 'Error adding prato');
      }
    });

    return router;
  }
}
