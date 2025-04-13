// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rick_and_morty/repositories/models/character.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 370,
        height: 500,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                height: 350,
                child: Image.network(character.image, fit: BoxFit.cover),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(character.name, style: TextStyle(fontSize: 12)),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(character.status, style: TextStyle(fontSize: 10)),
                      Text(character.species, style: TextStyle(fontSize: 10)),
                      Text(character.type, style: TextStyle(fontSize: 10)),
                    ],
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
