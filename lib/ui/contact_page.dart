import 'dart:io';

import 'package:flutter/material.dart';

import '../models/contact.dart';
import '../models/contact.dart';
import '../models/contact.dart';

class ContactPage extends StatefulWidget {
  final Contact contact;

  ContactPage({this.contact});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;
  Contact _contact;

  @override
  void initState() {
    super.initState();
    if (widget.contact == null) {
      this._contact = Contact();
    } else {
      this._contact = Contact.fromMap(widget.contact.toMap());
    }

    _nameController.text = _contact.name;
    _emailController.text = _contact.email;
    _phoneController.text = _contact.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.name ?? 'Novo Contato'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_contact.name != null && _contact.name.isNotEmpty) {
            Navigator.pop(context, _contact);
          } else {
            FocusScope.of(context).requestFocus(_nameFocus);
          }
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            GestureDetector(
              child: Container(
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _getImageContact(_contact.image),
                  ),
                ),
              ),
            ),
            TextField(
              controller: _nameController,
              focusNode: _nameFocus,
              decoration: InputDecoration(labelText: 'Nome'),
              style: TextStyle(color: Colors.black),
              onChanged: (text) {
                _userEdited = true;
                setState(() => _contact.name = text);
              },
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              style: TextStyle(color: Colors.black),
              onChanged: (text) {
                _userEdited = true;
                _contact.email = text;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              style: TextStyle(color: Colors.black),
              onChanged: (text) {
                _userEdited = true;
                _contact.phone = text;
              },
              keyboardType: TextInputType.phone,
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
