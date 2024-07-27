import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/db.dart'; // Importação de pacote

class Handlers {
  Router get router {
    final router = Router();

    router.get('/pratos', (Request request) async {
      try {
        var results =
            await Database().connection.query('SELECT * FROM "tb_cad_prato"');
        return Response.ok(results.toString());
      } catch (e, stacktrace) {
        print('Error fetching pratos: $e');
        print('Stacktrace: $stacktrace');
        return Response.internalServerError(body: 'Error fetching pratos');
      }
    });

    router.post('/adicionar_prato', (Request request) async {
      try {
        var params = request.url.queryParameters;
        var nome = params['nome'];
        var preco = params['preco'];
        await Database().connection.query(
          'INSERT INTO "tb_cad_prato" (nome, preco) VALUES (@nome, @preco)',
          substitutionValues: {'nome': nome, 'preco': preco},
        );
        return Response.ok('Prato adicionado');
      } catch (e, stacktrace) {
        print('Error adding prato: $e');
        print('Stacktrace: $stacktrace');
        return Response.internalServerError(body: 'Error adding prato');
      }
    });

    return router;
  }
}
