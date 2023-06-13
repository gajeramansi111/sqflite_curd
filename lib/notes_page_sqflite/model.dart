import 'dart:convert';

class NotesModel {
  final int? id;
  final String? title;
  final String? description;
  final List<dynamic>? image;
  final String? audio;

  NotesModel({
    this.id,
    this.audio,
    this.title,
    this.description,
    this.image,
  });

  NotesModel.fromMap(
    Map<String, dynamic> res,
  )   : id = res['id'],
        audio = res['audio'],
        title = res['title'],
        description = res['description'],
        image = json.decode(
          res['image'],
        );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'audio': audio,
      'title': title,
      'description': description,
      'image': json.encode(image),
    };
  }
}
