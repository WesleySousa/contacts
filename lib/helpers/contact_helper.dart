import 'package:contacts/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:contacts/models/contact.dart';
import 'package:path/path.dart';
import 'dart:async';

class ContactHelper {
  static final String _databaseName = 'contacts.db';
  static final int _databaseVersion = 1;
  static final ContactHelper _instance = ContactHelper._internal();

  factory ContactHelper() => _instance;

  ContactHelper._internal();

  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: (db, newerVersion) async {
        await db.execute('CREATE TABLE ${Contact.contactTable}(' +
            '${Contact.idColumn} INTEGER PRIMARY KEY,' +
            '${Contact.nameColumn} VARCHAR(50), ' +
            '${Contact.emailColumn} VARCHAR(50), ' +
            '${Contact.phoneColumn} VARCHAR(20), ' +
            '${Contact.imageColumn} TEXT)');
      },
    );
  }
}
