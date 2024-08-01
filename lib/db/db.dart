import 'package:postgres/postgres.dart';

class Database {
  static final Database _instance = Database._internal();
  late PostgreSQLConnection _connection;

  factory Database() {
    return _instance;
  }

  Database._internal();

  PostgreSQLConnection get connection => _connection;

  Future<void> connect() async {
    _connection = PostgreSQLConnection(
      'localhost',
      5432,
      'db_restaurante',
      username: 'postgres',
      password: '@Inspiron1',
    );
    await _connection.open();
    print('Database connection established');
  }
}
