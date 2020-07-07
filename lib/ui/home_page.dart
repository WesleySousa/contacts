import 'dart:io';

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
        padding: EdgeInsets.all(8.0),
        itemCount: _contacts.length,
        itemBuilder: (context, index) {
          return _contactCard(context, index);
        },
      ),
    );
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _getImageContact(_contacts[index].image),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _contacts[index].name ?? '',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    _contacts[index].email ?? '',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    _contacts[index].phone ?? '',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider _getImageContact(String image) {
    if (image == null) {
      return const AssetImage('images/person.png');
    } else {
      final _imageFile = File(image);
      if (_imageFile.existsSync())
        return FileImage(_imageFile);
      else
        return AssetImage('images/person.png');
    }
  }
}
