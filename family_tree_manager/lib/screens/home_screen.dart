import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import '../models/person.dart';
import '../services/realm_service.dart';
import 'add_person_screen.dart';
import 'person_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final realmService = Provider.of<RealmService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý Gia phả'),
      ),
      body: Consumer<RealmService>(
        builder: (context, service, child) {
          final persons = service.getPersons().where((person) => person.relationshipId.isEmpty).toList();

          if (persons.isEmpty) {
            return Center(child: Text('No persons in family tree'));
          } else {
            return ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                final person = persons[index];
                return ListTile(
                  title: Text(person.name),
                  subtitle: Text('${person.birthDate} - ${person.relationship} - ${person.gender}'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonDetailScreen(person: person)),
                    );
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      service.deletePerson(person.id);
                      (context as Element).reassemble();
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPersonScreen()),
          ).then((_) {
            (context as Element).reassemble();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
