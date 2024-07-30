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

  static Future<List<Map<String, dynamic>>> listarImagens() async {
    var results = await Database().connection.query('SELECT * FROM tb_imagens');
    return results
        .map((row) => {
              'id': row[0],
              'nome': row[1],
              'caminho': row[2],
              'data_criacao': row[3].toString(),
            })
        .toList();
  }

  static Future<void> editarImagem(int id, String nome) async {
    try {
      await Database().connection.query(
          'UPDATE tb_imagens SET nome = @nome WHERE id = @id',
          substitutionValues: {'nome': nome, 'id': id});
    } catch (e) {
      print('Error updating image: $e');
      throw Exception('Error updating image');
    }
  }

  static Future<void> excluirImagem(int id) async {
    try {
      await Database().connection.query('DELETE FROM tb_imagens WHERE id = @id',
          substitutionValues: {'id': id});
    } catch (e) {
      print('Error deleting image: $e');
      throw Exception('Error deleting image');
    }
  }
}
