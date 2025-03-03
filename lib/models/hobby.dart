class Hobby {
  final int id;
  final String titre;
  final String auteur;
  final String description;
  final String datePublication;
  final String? imageRepository;
  final String? imageFileName;
  final double? prix;
  final String? emailContact;
  final double? latitude;
  final double? longitude;

  Hobby({
    required this.id,
    required this.titre,
    required this.auteur,
    required this.description,
    required this.datePublication,
    this.imageRepository,
    this.imageFileName,
    this.prix,
    this.emailContact,
    this.latitude,
    this.longitude,
  });

  // Factory method to create an object from JSON
  factory Hobby.fromJson(Map<String, dynamic> json) {
    return Hobby(
      id: json["Id"],
      titre: json["Titre"],
      auteur: json["Auteur"],
      description: json["Description"],
      datePublication: json["DatePublication"],
      imageRepository: json["ImageRepository"],
      imageFileName: json["ImageFileName"],
      prix: json["Prix"] != null ? double.tryParse(json["Prix"].toString()) : null,
      emailContact: json["EmailContact"],
      latitude: json["Latitude"] != null ? double.tryParse(json["Latitude"].toString()) : null,
      longitude: json["Longitude"] != null ? double.tryParse(json["Longitude"].toString()) : null,
    );
  }
}
