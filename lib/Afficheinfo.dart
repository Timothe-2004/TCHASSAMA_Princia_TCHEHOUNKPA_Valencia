import 'package:flutter/material.dart';
import 'package:controlelection/Candidats.dart';

class AfficheInfo extends StatelessWidget {
  final Candidate candidate;

  AfficheInfo({required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations du candidat'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Partie politique: ${candidate.parti_politique}'),
            SizedBox(height: 8),
            Text('Nom: ${candidate.name}'),
            SizedBox(height: 8),
            Text('Prénom: ${candidate.firstName}'),
            SizedBox(height: 8),
            Text('Description: ${candidate.description}'),
            SizedBox(height: 8),
            Image.network(
              candidate.imageUrl,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
