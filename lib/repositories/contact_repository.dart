import 'package:contacts/helpers/contact_helper.dart';
import 'package:contacts/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {
  ContactHelper _contactHelper;

  ContactRepository() {
    _contactHelper = ContactHelper();
  }

  Future<Contact> save(Contact contact) async {
    Database _db = await _contactHelper.db;
    contact.id = await _db.insert(Contact.contactTable, contact.toMap());
    return contact;
  }

  Future<Contact> findById(int id) async {
    Database _db = await _contactHelper.db;
    List<Map> maps = await _db.query(
      Contact.contactTable,
      columns: [
        Contact.idColumn,
        Contact.nameColumn,
        Contact.emailColumn,
        Contact.phoneColumn,
        Contact.imageColumn
      ],
      where: '${Contact.idColumn} = ?',
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database _db = await _contactHelper.db;
    return await _db.delete(
      Contact.contactTable,
      where: '${Contact.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(Contact contact) async {
    Database _db = await _contactHelper.db;
    return await _db.update(
      Contact.contactTable,
      contact.toMap(),
      where: '${Contact.idColumn} = ?',
      whereArgs: [contact.id],
    );
  }

  Future<List<Contact>> findAll() async {
    Database _db = await _contactHelper.db;
    List<Map> maps = await _db.query(Contact.contactTable, columns: [
      Contact.idColumn,
      Contact.nameColumn,
      Contact.emailColumn,
      Contact.phoneColumn,
      Contact.imageColumn
    ]);

    List<Contact> contacts = List();
    maps.forEach((map) => contacts.add(Contact.fromMap(map)));
    return contacts;
  }

  Future<int> getCountContacts() async {
    Database _db = await _contactHelper.db;
    return Sqflite.firstIntValue(
        await _db.rawQuery('SELECT COUNT(*) FROM ${Contact.contactTable};'));
  }

  Future close() async {
    Database _db = await _contactHelper.db;
    await _db.close();
  }
}
