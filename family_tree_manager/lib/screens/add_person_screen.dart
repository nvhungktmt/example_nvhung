import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import '../models/person.dart';
import '../services/realm_service.dart';

class AddPersonScreen extends StatefulWidget {
  final String? defaultRelationshipId;

  AddPersonScreen({this.defaultRelationshipId});

  @override
  _AddPersonScreenState createState() => _AddPersonScreenState();
}

class _AddPersonScreenState extends State<AddPersonScreen> {
  final _nameController = TextEditingController();
  final _relationshipController = TextEditingController();

  DateTime? _selectedDate;
  String? _selectedGender;

  final List<String> _relationships = ['Bố', 'Mẹ', 'Con trai', 'Con gái', 'Vợ', 'Chồng', 'Bạn'];

  final List<String> _genders = ['Nam', 'Nữ'];

  @override
  Widget build(BuildContext context) {
    final realmService = Provider.of<RealmService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Người'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Tên',
                errorText: _nameController.text.isEmpty ? 'Tên là bắt buộc' : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text(_selectedDate == null ? 'Chọn ngày sinh' : 'Ngày sinh: ${_selectedDate!.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        _selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
            TextField(
              controller: _relationshipController,
              decoration: InputDecoration(labelText: 'Quan hệ (hoặc chọn từ danh sách)'),
            ),
            DropdownButton<String>(
              hint: Text('Chọn Quan hệ'),
              value: _relationshipController.text.isEmpty ? null : _relationshipController.text,
              onChanged: (newValue) {
                setState(() {
                  _relationshipController.text = newValue!;
                });
              },
              items: _relationships.map((relationship) {
                return DropdownMenuItem(
                  child: Text(relationship),
                  value: relationship,
                );
              }).toList(),
            ),
            if (widget.defaultRelationshipId == null)
              DropdownButton<Person>(
                hint: Text('Chọn ID Quan hệ'),
                value: null,
                onChanged: (newValue) {},
                items: [],
              ),
            DropdownButton<String>(
              hint: Text('Chọn Giới tính'),
              value: _selectedGender,
              onChanged: (newValue) {
                setState(() {
                  _selectedGender = newValue;
                });
              },
              items: _genders.map((gender) {
                return DropdownMenuItem(
                  child: Text(gender),
                  value: gender,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _nameController.text.isNotEmpty
                  ? () {
                      final name = _nameController.text;
                      final birthDate = _selectedDate?.toLocal().toString().split(' ')[0] ?? '';
                      final relationship = _relationshipController.text;
                      final relationshipId = widget.defaultRelationshipId ?? '';
                      final gender = _selectedGender ?? '';

                      if (name.isNotEmpty) {
                        final newPerson = Person(
                          ObjectId(),
                          name,
                          birthDate,
                          relationship,
                          relationshipId,
                          gender,
                        );
                        realmService.insertPerson(newPerson);
                        Navigator.pop(context);
                      }
                    }
                  : null,
              child: Text('Thêm'),
            ),
          ],
        ),
      ),
    );
  }
}
