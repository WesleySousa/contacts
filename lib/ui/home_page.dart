import 'package:contacts/helpers/contact_image.dart';
import 'package:contacts/models/contact.dart';
import 'package:contacts/repositories/contact_repository.dart';
import 'package:contacts/ui/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';

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
    _loadContacts();
  }

  void _loadContacts() {
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
        onPressed: _showContactPage,
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
      onTap: () => _showOptions(context, index),
      child: Card(
        child: Row(
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: ContactImage.get(_contacts[index].image),
                  fit: BoxFit.cover
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

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buttonBottomSheet(
                    'Ligar',
                    onPressed: () {
                      Navigator.pop(context);
                      launch('tel:${_contacts[index].phone}');
                    },
                  ),
                  _buttonBottomSheet(
                    'Editar',
                    onPressed: () {
                      Navigator.pop(context);
                      _showContactPage(contact: _contacts[index]);
                    },
                  ),
                  _buttonBottomSheet(
                    'Excluir',
                    onPressed: () {
                      Navigator.pop(context);
                      _contactRepository.delete(_contacts[index].id);
                      setState(() => _contacts.removeAt(index));
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buttonBottomSheet(String name, {Function onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactPage(
          contact: contact,
        ),
      ),
    );

    if (recContact != null) {
      if (contact != null) {
        await _contactRepository.update(recContact);
      } else {
        await _contactRepository.save(recContact);
      }
      _loadContacts();
    }
  }
}
