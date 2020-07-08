import 'package:contacts/helpers/contact_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: ContactImage.get(_contact.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  ImagePicker imagePicker = ImagePicker();
                  imagePicker
                      .getImage(source: ImageSource.camera)
                      .then((value) {
                    if (value == null) return;
                    setState(() => _contact.image = value.path);
                    _userEdited = true;
                  });
                },
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
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Descartar alterações?'),
            content: Text('Se sair as alterações seram perdidas.'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Sim'),
              ),
            ],
          );
        },
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
