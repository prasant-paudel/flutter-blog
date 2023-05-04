import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'blog_controller.dart';
import 'blog_create_update_page.dart';
import 'blog_detail_page.dart';
import 'blog_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: BlogController.to.blogs.length,
          itemBuilder: (context, index) {
            return BlogCard(
              BlogController.to.blogs[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Get.to(() => const BlogCreateUpdatePage(action: BlogAction.create)),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard(this.blog, {super.key});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BlogDetailPage(blog)),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Column(
            children: [
              // -------------------- Image --------------------
              if (blog.image != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      blog.image!,
                      height: 104,
                      width: 104,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              // -------------------- Title --------------------
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  blog.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // -------------------- Divider --------------------
              const Divider(
                thickness: 1.5,
              ),
              // -------------------- Description --------------------
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  blog.description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // -------------------- Edit Button --------------------
                  ElevatedButton(
                      onPressed: () => Get.to(() => const BlogCreateUpdatePage(
                            action: BlogAction.update,
                          )),
                      child: const Text('Edit')),
                  const SizedBox(width: 8),
                  // -------------------- Delete Button --------------------
                  ElevatedButton(
                    onPressed: () => BlogController.to.deleteBlog(blog),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: const Text('Delete'),
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
