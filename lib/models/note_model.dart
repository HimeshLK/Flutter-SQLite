class Note {
  final int? id;
  final String title;
  final String description;
  final String vcomment;

  const Note(
      {required this.vcomment,
      required this.title,
      required this.description,
      this.id});

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: json['id'],
        vcomment: json['vcomment'],
        title: json['title'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'vcomment': vcomment
      };
}
