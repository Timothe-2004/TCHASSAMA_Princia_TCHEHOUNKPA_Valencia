class Candidate {
  final String name;
  final String firstName;
  final String description;
  final String parti_politique;
  final String date_naissance;
  final String imageUrl;
  bool selected;

  Candidate({
    required this.name,
    required this.firstName,
    required this.description,
    required this.parti_politique,
    required this.date_naissance,
    required this.imageUrl,
    this.selected = false,
  });
}
