import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'character.g.dart';

@HiveType(typeId: 0)
class Character extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String image;
  @HiveField(3)
  final String status;
  @HiveField(4)
  final String species;
  @HiveField(5)
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
