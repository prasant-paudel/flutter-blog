import 'dart:io';

class Blog {
  final String id;
  final String title;
  final String description;
  File? image;
  String? imagePath;

  Blog({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    this.imagePath,
  });

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imagePath: json['imagePath'],
      image: json['imagePath'] != null ? File(json['imagePath']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
    };
  }
}
