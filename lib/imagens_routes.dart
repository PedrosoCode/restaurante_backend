import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:restaurante_backend/imagens_controller.dart';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class ImagensRoutes {
  Router get router {
    final router = Router();

    router.post('/upload', (Request request) async {
      try {
        // Processa o corpo do request para obter os dados do formulário
        var boundary = request.headers['content-type']!.split('boundary=')[1];
        var transformer = MimeMultipartTransformer(boundary);
        var bodyStream = request.read();
        var parts = await transformer.bind(bodyStream).toList();

        String? nome;
        File? imagemFile;

        for (var part in parts) {
          var contentDisposition = part.headers['content-disposition'];
          if (contentDisposition != null &&
              contentDisposition.contains('name="nome"')) {
            nome = await utf8.decoder.bind(part).join();
          } else if (contentDisposition != null &&
              contentDisposition.contains('name="imagem"')) {
            var filename =
                contentDisposition.split('filename=')[1].replaceAll('"', '');
            var file = File('../arquivos/imagens/$filename');
            var sink = file.openWrite();
            await part.pipe(sink);
            imagemFile = file;
          }
        }

        if (nome == null || imagemFile == null) {
          return Response.badRequest(body: 'Missing nome or imagem parameter');
        }

        await ImagensController.uploadImagem(imagemFile, nome);
        return Response.ok('Imagem adicionada');
      } catch (e) {
        print('Error uploading image: $e');
        return Response.internalServerError(body: 'Error uploading image');
      }
    });

    return router;
  }
}
