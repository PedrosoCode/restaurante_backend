import 'dart:io';
import 'package:restaurante_backend/db.dart';
import 'package:uuid/uuid.dart';

class ImagensController {
  static Future<void> uploadImagem(File imagem, String nome) async {
    var uuid = Uuid();
    var extension = imagem.uri.pathSegments.last.split('.').last;
    var imgPath = '../arquivos/imagens${uuid.v4()}.$extension';
    var newFile = File(imgPath);

    try {
      await imagem.copy(newFile.path); // Salva a imagem no servidor

      await Database().connection.query(
        'INSERT INTO tb_imagens (nome, caminho) VALUES (@nome, @caminho)',
        substitutionValues: {'nome': nome, 'caminho': imgPath},
      );
    } catch (e) {
      print('Error uploading image: $e');
      throw Exception('Error uploading image');
    }
  }
}
