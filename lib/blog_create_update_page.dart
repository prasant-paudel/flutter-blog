import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'blog_controller.dart';
import 'blog_model.dart';

enum BlogAction {
  create,
  update,
}

class BlogCreateUpdatePage extends StatelessWidget {
  const BlogCreateUpdatePage({required this.action, this.blog, super.key});

  final BlogAction action;
  final Blog? blog;

  @override
  Widget build(BuildContext context) {
    BlogController.to.titleController.text = blog?.title ?? '';
    BlogController.to.descriptionController.text = blog?.description ?? '';
    BlogController.to.image.value = blog?.image;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          action == BlogAction.create ? 'Create Blog' : 'Update Blog',
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              // -------------------- Image --------------------
              Center(
                child: ClipOval(
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Obx(
                      () => BlogController.to.image.value != null
                          ? Image.file(BlogController.to.image.value!)
                          : Image.network('https://picsum.photos/250?image=9'),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // -------------------- Upload Image Button --------------------
              ElevatedButton(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const SelectImageSourceBottomSheet(),
                ),
                child: const Text('Upload Image'),
              ),

              const SizedBox(height: 16),

              // -------------------- Title Input Field --------------------
              TextFormField(
                controller: BlogController.to.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // -------------------- Description Input Field --------------------
              TextFormField(
                controller: BlogController.to.descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),

              const SizedBox(height: 32),

              // -------------------- Save Button --------------------
              ElevatedButton(
                onPressed: () {
                  if (action == BlogAction.update) {
                    BlogController.to.updateBlog(Blog(
                      id: blog!.id,
                      title: BlogController.to.titleController.text,
                      description: BlogController.to.descriptionController.text,
                      image: BlogController.to.image.value,
                    ));
                  } else {
                    BlogController.to.addBlog(Blog(
                      id: DateTime.now().toString(),
                      title: BlogController.to.titleController.text,
                      description: BlogController.to.descriptionController.text,
                      image: BlogController.to.image.value,
                    ));
                  }
                  Get.back();
                },
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageSourceBottomSheet extends StatelessWidget {
  const SelectImageSourceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        // -------------------- Camera --------------------
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () => BlogController.to.pickImage(ImageSource.camera),
        ),

        // -------------------- Gallery --------------------
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Gallery'),
          onTap: () => BlogController.to.pickImage(ImageSource.gallery),
        ),
      ],
    );
  }
}
