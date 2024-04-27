import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:controlelection/Candidats.dart';

class Formulaire extends StatefulWidget {
  final Function(Candidate) onSubmit;

  Formulaire({required this.onSubmit});

  @override
  _FormulaireState createState() => _FormulaireState();
}

class _FormulaireState extends State<Formulaire> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _firstName = '';
  String _description = '';
  String _partipolitique = '';
  String _imageUrl = '';
  DateTime? _selectedDate;

  Future<void> _saveToJson() async {
    final data = [
      {
        "name": _name,
        "firstName": _firstName,
        "description": _description,
        "parti_politique": _partipolitique,
        "imageUrl": _imageUrl,
        "date_naissance": _selectedDate?.toIso8601String(),
      },
    ];

    final String jsonString = jsonEncode(data);
    await rootBundle.loadString('assets/data.json').then((value) {
      final existingData = jsonDecode(value);
      final updatedData = [...existingData, ...data];
      final updatedJsonString = jsonEncode(updatedData);
      rootBundle.load('assets/data.json').then((byteData) {
        byteData.buffer.asUint8List().setAll(0, updatedJsonString.codeUnits);
      });
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(Candidate(
        name: _name,
        firstName: _firstName,
        description: _description,
        parti_politique: _partipolitique,
        imageUrl: _imageUrl,
          date_naissance: _selectedDate?.toIso8601String() ?? ''      ));
      _saveToJson();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nouveau Candidat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le nom du candidat';
                          }
                          return null;
                        },
                        onSaved: (value) => _name = value!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.person_outline),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Prénom',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer le prénom du candidat';
                          }
                          return null;
                        },
                        onSaved: (value) => _firstName = value!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.flag),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Parti politique',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer votre parti politique';
                          }
                          return null;
                        },
                        onSaved: (value) => _partipolitique = value!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Icon(Icons.description),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onSaved: (value) => _description = value!,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'URL de la photo',
                    prefixIcon: Icon(Icons.image),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onSaved: (value) => _imageUrl = value!,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: _selectedDate != null ? _selectedDate.toString() : 'Sélectionner une date',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Date d\'anniversaire',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectedDate ?? DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null && pickedDate != _selectedDate) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(height: 32.0),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _submitForm,
          child: Text('Sauvegarder'),
        ),
      ),
    );
  }
}
