import 'package:flutter/material.dart';

import 'blog_model.dart';

class BlogDetailPage extends StatelessWidget {
  const BlogDetailPage(this.blog, {super.key});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blog.title),
      ),
      body: Column(
        children: [
          // -------------------- Image --------------------
          if (blog.image != null)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.file(
                  blog.image!,
                  height: 160,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
            ),

          // -------------------- Description --------------------
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(blog.description),
          ),
        ],
      ),
    );
  }
}
