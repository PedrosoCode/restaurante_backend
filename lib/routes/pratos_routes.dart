import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/controllers/pratos_controller.dart';
import 'dart:convert';

class PratosRoutes {
  Router get router {
    final router = Router();

    router.get('/', (Request request) async {
      try {
        var pratos = await PratosController.getPratos();
        return Response.ok(jsonEncode(pratos),
            headers: {'Content-Type': 'application/json'});
      } catch (e) {
        print('Error fetching pratos: $e');
        return Response.internalServerError(body: 'Error fetching pratos');
      }
    });

    router.post('/adicionar', (Request request) async {
      try {
        var payload = await request.readAsString();
        var params = Uri.splitQueryString(payload);
        var nome = params['nome'];
        var preco = params['preco'];

        if (nome == null || preco == null) {
          return Response.badRequest(body: 'Missing nome or preco parameter');
        }

        print(
            'Received: nome=$nome, preco=$preco'); // Log dos parâmetros recebidos

        await PratosController.adicionarPrato(nome, preco);
        return Response.ok('Prato adicionado');
      } catch (e) {
        print('Error adding prato: $e');
        return Response.internalServerError(body: 'Error adding prato');
      }
    });

    router.delete('/deletar/<id>', (Request request, String id) async {
      try {
        await PratosController.deletarPrato(int.parse(id));
        return Response.ok('Prato deletado');
      } catch (e) {
        print('Error deleting prato: $e');
        return Response.internalServerError(body: 'Error deleting prato');
      }
    });

    router.put('/atualizar/<id>', (Request request, String id) async {
      try {
        var payload = await request.readAsString();
        var params = Uri.splitQueryString(payload);
        var nome = params['nome'];
        var preco = params['preco'];

        if (nome == null || preco == null) {
          return Response.badRequest(body: 'Missing nome or preco parameter');
        }

        print(
            'Received: id=$id, nome=$nome, preco=$preco'); // Log dos parâmetros recebidos

        await PratosController.atualizarPrato(int.parse(id), nome, preco);
        return Response.ok('Prato atualizado');
      } catch (e) {
        print('Error updating prato: $e');
        return Response.internalServerError(body: 'Error updating prato');
      }
    });

    return router;
  }
}
