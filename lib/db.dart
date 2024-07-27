import 'package:postgres/postgres.dart';

class Database {
  static final Database _instance = Database._internal();
  late PostgreSQLConnection _connection;

  factory Database() {
    return _instance;
  }

  Database._internal();

  Future<void> connect() async {
    _connection = PostgreSQLConnection(
      'localhost', // Host
      5432, // Port
      'db_restaurante', // Database name
      username: 'postgres', // Username
      password: '@Inspiron1', // Password
    );
    await _connection.open();
  }

  PostgreSQLConnection get connection => _connection;
}
