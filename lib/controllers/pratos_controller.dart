import 'package:restaurante_backend/db/db.dart'; // Importação de pacote

class PratosController {
  static Future<List<Map<String, dynamic>>> getPratos() async {
    try {
      var results =
          await Database().connection.query('SELECT * FROM tb_cad_prato');
      return results
          .map((row) => {'id': row[0], 'nome': row[1], 'preco': row[2]})
          .toList();
    } catch (e) {
      print('Error fetching pratos: $e');
      throw Exception('Error fetching pratos');
    }
  }

  static Future<void> adicionarPrato(String nome, String preco) async {
    try {
      await Database().connection.query(
        'INSERT INTO tb_cad_prato (nome, preco) VALUES (@nome, @preco)',
        substitutionValues: {'nome': nome, 'preco': preco},
      );
    } catch (e) {
      print('Error adding prato: $e');
      throw Exception('Error adding prato');
    }
  }

  static Future<void> deletarPrato(int id) async {
    try {
      await Database().connection.query(
        'DELETE FROM tb_cad_prato WHERE id = @id',
        substitutionValues: {'id': id},
      );
    } catch (e) {
      print('Error deleting prato: $e');
      throw Exception('Error deleting prato');
    }
  }

  static Future<void> atualizarPrato(int id, String nome, String preco) async {
    try {
      await Database().connection.query(
        'UPDATE tb_cad_prato SET nome = @nome, preco = @preco WHERE id = @id',
        substitutionValues: {'id': id, 'nome': nome, 'preco': preco},
      );
    } catch (e) {
      print('Error updating prato: $e');
      throw Exception('Error updating prato');
    }
  }
}
