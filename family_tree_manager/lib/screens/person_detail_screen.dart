import 'package:family_tree_manager/screens/add_person_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/person.dart';
import '../services/realm_service.dart';

class PersonDetailScreen extends StatelessWidget {
  final Person person;

  PersonDetailScreen({required this.person});

  @override
  Widget build(BuildContext context) {
    final realmService = Provider.of<RealmService>(context);
    final relatedPersons = realmService.getRelatedPersons(person.id.hexString);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết người'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tên: ${person.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Ngày sinh: ${person.birthDate}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Quan hệ: ${person.relationship}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('ID Quan hệ: ${person.relationshipId}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Giới tính: ${person.gender}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Danh sách người có mối quan hệ:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: relatedPersons.isEmpty
                  ? Text('Không có người nào liên quan', style: TextStyle(fontSize: 16))
                  : ListView.builder(
                      itemCount: relatedPersons.length,
                      itemBuilder: (context, index) {
                        final relatedPerson = relatedPersons[index];
                        return ListTile(
                          title: Text(relatedPerson.name),
                          subtitle: Text('${relatedPerson.birthDate} - ${relatedPerson.relationship} - ${relatedPerson.gender}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PersonDetailScreen(person: relatedPerson)),
                            );
                          },
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              realmService.deletePerson(relatedPerson.id);
                              (context as Element).reassemble();
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPersonScreen(defaultRelationshipId: person.id.hexString)),
          ).then((_) {
            (context as Element).reassemble();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
