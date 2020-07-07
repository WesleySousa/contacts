import 'package:contacts/models/contact.dart';
import 'package:contacts/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactRepository _contactRepository = ContactRepository();

  @override
  void initState() {
    super.initState();
    
    /*Contact contact = Contact();
    contact.name = 'Helena Vanessa Jennifer Teixeira';
    contact.email = 'helenavanessajenniferteixeira@vivo.com.br';
    contact.phone = '(91) 2613-5767';
    contact.image = 'imgtest';
    _contactRepository.save(contact);
    */
    _contactRepository.findAll().then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}