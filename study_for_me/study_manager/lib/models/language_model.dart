class Language {
  final String? id;
  final String name;
  final String description;
  final double progress;

  Language({this.id, required this.name, required this.description, this.progress = 0});

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      progress: json['progress']?.toDouble() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'progress': progress,
    };
  }
}