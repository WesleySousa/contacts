import 'package:contacts/models/contact.dart';
import 'package:contacts/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactRepository _contactRepository = ContactRepository();

  List<Contact> _contacts = List();

  @override
  void initState() {
    super.initState();
    _contactRepository.findAll().then((contacts) {
      setState(() => this._contacts = contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return;
        },
      ),
    );
  }
}
