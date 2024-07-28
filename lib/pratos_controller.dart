import 'package:restaurante_backend/db.dart'; // Importação de pacote

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
}
