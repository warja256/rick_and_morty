import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String type;

  const Character({
    required this.image,
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, image, status, species, type];

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      image: json['image'],
    );
  }
}
