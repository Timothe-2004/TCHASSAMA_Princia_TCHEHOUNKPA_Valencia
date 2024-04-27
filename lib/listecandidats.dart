import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:controlelection/Candidats.dart';
import 'package:controlelection/formulaire.dart';
import 'package:controlelection/Afficheinfo.dart';


class Candidats extends StatefulWidget {
  @override
  _CandidatsState createState() => _CandidatsState();
}

class _CandidatsState extends State<Candidats> {
  List<Candidate> candidates = [];
  Candidate? selectedCandidate;

  @override
  void initState() {
    super.initState();
    _loadCandidatesFromJson();
  }

  Future<void> _loadCandidatesFromJson() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = await json.decode(response);
    setState(() {
      candidates = (data as List)
          .map((item) => Candidate(
        name: item['name'],
        firstName: item['firstName'],
        parti_politique: item['Partie politique'],
        description: item['description'],
        date_naissance: item ['Date de naissance'],
        imageUrl: item['imageUrl'],
      ))
          .toList();
    });
  }

  void _showFormDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Formulaire(
          onSubmit: (candidate) {
            setState(() {
              candidates.add(candidate);
            });
            _loadCandidatesFromJson();
          },
        );
      },
    );
  }

  void _selectCandidate(Candidate candidate) {
    setState(() {
      selectedCandidate = candidate;
    });
    if (selectedCandidate != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AfficheInfo(candidate: selectedCandidate!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Elections'),
            SizedBox(width: 8.0), // Ajoutez un espace entre le drapeau et le texte
            Image.asset(
              'assets/drapeau.jpeg', // Remplacez par le chemin de votre image de drapeau
              height: 20.0, // Ajustez la taille du drapeau selon vos besoins

            ),
            SizedBox(width: 6.0),
            Image.asset(
              'assets/drapeau.jpeg', // Remplacez par le chemin de votre image de drapeau
              height: 20.0, // Ajustez la taille du drapeau selon vos besoins

            ),
          ],
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: candidates.length,
        itemBuilder: (BuildContext context, int index) {
          final candidate = candidates[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(candidate.imageUrl),
            ),
            title: Text('${candidate.name} ${candidate.firstName}'),
            subtitle: Text(candidate.description),
            selected: selectedCandidate == candidate,
            onTap: () {
              _selectCandidate(candidate);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFormDialog,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
               label: "Candidats",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote),
            label: 'Vote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
